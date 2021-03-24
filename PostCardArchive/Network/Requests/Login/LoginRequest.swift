//
//  LoginRequest.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class LoginRequest: HttpRequest<LoginRequestBody, String> {
    
    override var urlString: String {
        return "\(ServiceUrls.mainServiceUrl)login.php?json=1"
    }
    
    override var method: String {
        return "POST"
    }
    
    func login(body: LoginRequestBody, complete: @escaping (_ error: NetworkError?) -> Void) {
        complete(nil)
        return
//        execute(body: body, complete: {
//            result in
//            switch result {
//            case .success( _):
//                complete(nil)
//            case .failure(let networkError):
//                complete(networkError)
//            }
//        })

    }
    
}
