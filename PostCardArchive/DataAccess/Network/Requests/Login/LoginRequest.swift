//
//  LoginRequest.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class LoginRequest {
    
    var urlString: String {
        return "\(ServiceUrls.mainServiceUrl)login.php?json=1"
    }
    
    var method: String {
        return "POST"
    }
    
    func login(body: LoginRequestBody, complete: @escaping (_ error: NetworkError?) -> Void) {
//        complete(nil)
//        return
        execute(body: body, complete: {
            result in
            switch result {
            case .success( _):
                complete(nil)
            case .failure(let networkError):
                complete(networkError)
            }
        })

    }
    
    func execute(body: LoginRequestBody?, complete: @escaping (Result<LoginRequestResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            complete(.failure(.apiError(statusCode: 404)))
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if body != nil {
                
                let jsonEncoder = JSONEncoder()
                let boundary = "Boundary-\(UUID().uuidString)"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                let params: [String : String] = [
                    "email": body!.email,
                    "password": body!.password
                ]
                request.httpBody = createBody(parameters: params,
                                        boundary: boundary,
                                        data: Data(),
                                        mimeType: "image/jpg",
                                        filename: "hello.jpg")
            }
            
            
            
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
                        let result = try jsonDecoder.decode(LoginRequestResponse.self, from: data)
                        if result.success {
                            complete(.success(result))
                        } else {
                            complete(.failure(.decodingError))
                        }
                    } catch {
                        complete(.failure(.decodingError))
                    }
                }
            }).resume()
        } catch {
            complete(.failure(.encodingError))
        }
    }
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
