//
//  LoginViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class LoginViewModel: ControllerViewModel {
    
    var email: String = ""

    var password: String = ""
        
    func didClickOnLogin() {
        sendLoginRequestIfDataIsComplete()
    }
    
    private func sendLoginRequestIfDataIsComplete() {
        if dataIsComplete() {
            sendLoginRequest()
        } else {
            showDataInCompleteAlert()
        }
    }
    
    private func dataIsComplete() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    private func sendLoginRequest() {
        let loginRequest = LoginRequest()
        let loginBody = LoginRequestBody(email: email, password: password)
        loginRequest.login(body: loginBody, complete: {
            [weak self] error in
            if error == nil {
                print("Logged in")
            } else {
                self?.showUnableToLoginAlert()
            }
        })
    }
    
    private func showUnableToLoginAlert() {
        showAlert?("Error", "Unable to login", "Ok", nil)
    }
    
    private func showDataInCompleteAlert() {
        showAlert?("Error", "Please enter the email and password", "Ok", nil)
    }
    
    
    
}
