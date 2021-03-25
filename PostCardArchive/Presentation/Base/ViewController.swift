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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseClosures()
        setAdditionalClosures()
    }
    
    private func setBaseClosures() {
        viewModel.showAlert = {
            [weak self] title, message, buttonTitle, onButtonPress in
            DispatchQueue.main.async {
                self?.showNetworkError(title: title, message: message, buttonTitle: buttonTitle, onButtonPress: onButtonPress)
            }
        }
        
        viewModel.showConfirmAlert = {
            [weak self] title, message, cancelButtonTitle, confirmButtonTitle, onCancel, onConfirm in
            DispatchQueue.main.async {
                self?.showConfirm(title: title, message: message, cancelButtonTitle: cancelButtonTitle, confirmButtonTitle: confirmButtonTitle, onCancel: onCancel, onConfirm: onConfirm)
            }
        }
        
        viewModel.popViewController = {
            [weak self] animated in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: animated)
            }
        }
        
        viewModel.pushViewController = {
            [weak self] viewController, animated in
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(viewController, animated: animated)
            }
        }
        
        viewModel.presentViewController = {
            [weak self] viewController, animated, completion in
            DispatchQueue.main.async {
                self?.present(viewController, animated: animated, completion: completion)
            }
        }
        
        viewModel.dismissViewController = {
            [weak self] animated, completion in
            DispatchQueue.main.async {
                self?.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    func setAdditionalClosures() {
        // To be overriden by subclasses
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
    
    func showConfirm(title: String, message: String, cancelButtonTitle: String, confirmButtonTitle: String, onCancel: (() -> Void)?, onConfirm: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmButtonTitle, style: .default, handler: {
            _ in
            onConfirm?()
        })
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: {
            _ in
            onCancel?()
        })
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
