//
//  PreviewPostCardViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import UIKit

class PreviewPostCardViewController: ViewController<PreviewPostCardViewModel> {

    @IBOutlet private var postCardImageView: UIImageView! {
        didSet {
            postCardImageView.contentMode = .scaleAspectFit
            postCardImageView.image = UIImage(data: viewModel.postCardImageData)
        }
    }
    
    @IBOutlet private var frontTextLabel: UILabel! {
        didSet {
            frontTextLabel.font = .boldSystemFont(ofSize: 20)
            frontTextLabel.textColor = .label
            frontTextLabel.text = viewModel.postCardFrontText
        }
    }
    
    @IBOutlet private var backTextLabel: UILabel! {
        didSet {
            backTextLabel.font = .systemFont(ofSize: 14)
            backTextLabel.textColor = .label
            backTextLabel.text = viewModel.postCardBackText
        }
    }
    
    @IBOutlet private var actionButton: UIButton! {
        didSet {
            actionButton.setTitle("Next", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func didClickOnActionButton() {
        viewModel.didClickOnActionButton()
    }
    
}
