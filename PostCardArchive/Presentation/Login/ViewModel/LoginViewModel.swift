//
//  LoginViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation
import UIKit

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
                self?.navigateToMain()
            } else {
                self?.showUnableToLoginAlert()
            }
        })
    }
    
    private func navigateToMain() {
        DispatchQueue.main.async {
            let mainViewModel = MainViewModel()
            let mainViewController = MainViewController(viewModel: mainViewModel)
            let navigationController = UINavigationController(rootViewController: mainViewController)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    
    private func showUnableToLoginAlert() {
        showAlert?("Error", "Unable to login", "Ok", nil)
    }
    
    private func showDataInCompleteAlert() {
        showAlert?("Error", "Please enter the email and password", "Ok", nil)
    }
    
    
    
}
