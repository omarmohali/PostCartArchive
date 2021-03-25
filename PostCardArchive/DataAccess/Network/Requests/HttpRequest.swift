//
//  Requests.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class HttpRequest<BodyType: Encodable, ResponseType: Decodable> {
    
    var method: String {
        return "GET"
    }
    
    var urlString: String {
        return ""
    }
    
    func execute(body: BodyType?, complete: @escaping (Result<ResponseType, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            complete(.failure(.apiError(statusCode: 404)))
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if body != nil {
                let jsonEncoder = JSONEncoder()
                try request.httpBody = jsonEncoder.encode(body!)
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request, completionHandler: {
                data, urlResponse, error in
                
                guard let httpUrlResponse = urlResponse as? HTTPURLResponse, let data = data, error == nil  else {
                    complete(.failure(.noInternetConnection))
                    return
                }
                
                let statusCode = httpUrlResponse.statusCode
                if statusCode > 399 {
                    complete(.failure(.apiError(statusCode: statusCode)))
                } else {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(ResponseType.self, from: data)
                        complete(.success(result))
                    } catch {
                        complete(.failure(.decodingError))
                    }
                }
            }).resume()
        } catch {
            complete(.failure(.encodingError))
        }
    }
    
    
}
