//
//  ArchivedPostCardCell.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import UIKit

class ArchivedPostCardCell: UITableViewCell {

    @IBOutlet private var postCardImageView: UIImageView! {
        didSet {
            postCardImageView.contentMode = .scaleAspectFit
            
        }
    }
    
    @IBOutlet private var frontTextLabel: UILabel! {
        didSet {
            frontTextLabel.font = .boldSystemFont(ofSize: 16)
            frontTextLabel.textColor = .label
            
        }
    }
    
    @IBOutlet private var backTextLabel: UILabel! {
        didSet {
            backTextLabel.font = .systemFont(ofSize: 13)
            backTextLabel.textColor = .label
            
        }
    }
    
    
    var postCard: PostCard? {
        didSet {
            if let postCard = postCard {
                bindData(postCard: postCard)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func bindData(postCard: PostCard) {
        
        let typeText: String
        switch postCard.type {
        case .foldable:
            typeText = "Foldable"
        case .regular:
            typeText = "Regular"
        }
        postCardImageView.image = UIImage(data: postCard.imageData)
        frontTextLabel.text = "\(typeText): \(postCard.frontText)"
        backTextLabel.text = postCard.backText
    }
    
}
