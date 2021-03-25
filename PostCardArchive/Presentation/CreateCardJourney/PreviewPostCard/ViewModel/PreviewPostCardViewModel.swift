//
//  PreviewPostCardViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import Foundation

class PreviewPostCardViewModel: ControllerViewModel {
    
    private let postCard: PostCard
    
    var  postCardImageData: Data {
        return postCard.imageData
    }
    
    var postCardFrontText: String {
        return postCard.frontText
    }
    
    var postCardBackText: String? {
        return postCard.backText
    }
    
    init(postCard: PostCard) {
        self.postCard = postCard
        super.init()
    }
    
    func didClickOnActionButton() {
        showSaveAlert()
    }
    
    private func showSaveAlert() {
        showConfirmAlert?("Save", "Do you want to save this post card?", "Cancel", "Yes", nil, {
            [weak self] in
            guard let self = self else { return }
            let archivedPostCards = ArchivedPostCards()
            archivedPostCards.save(postCard: self.postCard)
            self.dismissViewController?(true, nil)
        })
    }
    
}

