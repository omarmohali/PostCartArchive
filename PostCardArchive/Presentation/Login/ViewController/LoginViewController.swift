//
//  LoginViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import UIKit

class LoginViewController: ViewController<LoginViewModel> {

    @IBOutlet private var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.borderStyle = .bezel
            emailTextField.placeholder = "email"
            emailTextField.addTarget(self, action: #selector(emailTextFieldTextChanged), for: .editingChanged)
        }
    }
    
    @IBOutlet private var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.borderStyle = .bezel
            passwordTextField.placeholder = "password"
            passwordTextField.addTarget(self, action: #selector(passwordTextFieldTextChanged), for: .editingChanged)
        }
    }
    
    @IBOutlet private var loginButton: UIButton! {
        didSet {
            loginButton.setTitle("Login", for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc private func emailTextFieldTextChanged() {
        viewModel.email = emailTextField.text ?? ""
    }

    @objc private func passwordTextFieldTextChanged() {
        viewModel.password = passwordTextField.text ?? ""
    }
    
    @IBAction private func actionOfLoginButton() {
        viewModel.didClickOnLogin()
    }

}
