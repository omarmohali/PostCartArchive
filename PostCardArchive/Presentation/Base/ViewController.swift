//
//  ViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import UIKit

class ViewController<ViewModelType: ControllerViewModel>: UIViewController {
    
    let viewModel: ViewModelType
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        viewModel.showAlert = {
            [weak self] title, message, buttonTitle, onButtonPress in
            DispatchQueue.main.async {
                self?.showNetworkError(title: title, message: message, buttonTitle: buttonTitle, onButtonPress: onButtonPress)
            }
        }
    }
    
    func showNetworkError(title: String, message: String, buttonTitle: String, onButtonPress: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {
            _ in
            onButtonPress?()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
