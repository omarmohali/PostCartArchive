//
//  MainViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import UIKit

class MainViewController: ViewController<MainViewModel> {

    @IBOutlet private var createCardButton: UIButton! {
        didSet {
            createCardButton.setTitle("Create Card", for: .normal)
        }
    }
    
    @IBOutlet private var viewArchivesButton: UIButton! {
        didSet {
            viewArchivesButton.setTitle(viewModel.numberOfArchivesButtonText, for: .normal)
        }
    }
        
    override func setAdditionalClosures() {
        viewModel.numberOfArchivesButtonTextDidChange = {
            [weak self] in
            DispatchQueue.main.async {
                self?.viewArchivesButton.setTitle(self?.viewModel.numberOfArchivesButtonText, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func actionOfCreateCardButton() {
        viewModel.didClickOnCreateCard()
    }
    
    @IBAction private func actionOfViewArchivesButton() {
        viewModel.didClickOnViewArchives()
    }
    
}
