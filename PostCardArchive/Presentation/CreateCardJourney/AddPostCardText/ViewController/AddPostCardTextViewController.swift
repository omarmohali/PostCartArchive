//
//  AddPostCardTextViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import UIKit

class AddPostCardTextViewController: ViewController<AddPostCardTextViewModel> {

    @IBOutlet private var fontTextLabel: UILabel! {
        didSet {
            fontTextLabel.textColor = .label
            fontTextLabel.text = "Front text"
        }
    }
    
    @IBOutlet private var backTextLabel: UILabel! {
        didSet {
            backTextLabel.textColor = .label
            backTextLabel.text = "Back text"
            backTextLabel.isHidden = !viewModel.showBackText
        }
    }
    
    @IBOutlet private var backTextTextView: UITextView! {
        didSet {
            backTextTextView.delegate = self
            backTextTextView.isHidden = !viewModel.showBackText
            backTextTextView.layer.cornerRadius = 3
            backTextTextView.layer.borderWidth = 1
            backTextTextView.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    @IBOutlet private var frontTextTextView: UITextView! {
        didSet {
            frontTextTextView.delegate = self
            frontTextTextView.layer.cornerRadius = 3
            frontTextTextView.layer.borderWidth = 1
            frontTextTextView.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    @IBOutlet private var nextButton: UIButton! {
        didSet {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionOfNextButton() {
        viewModel.didClickOnNext()
    }
    
}

extension AddPostCardTextViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == frontTextTextView {
            viewModel.frontText = frontTextTextView.text
        } else if textView == backTextTextView {
            viewModel.backText = backTextTextView.text
        }
    }
}
