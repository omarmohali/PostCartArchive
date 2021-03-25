//
//  AddPostCardTextViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import Foundation

class AddPostCardTextViewModel: ControllerViewModel {
    
    var frontText: String = ""
    
    var backText: String = ""
    
    let showBackText: Bool
    
    private let imageData: Data
    private let cardType: PostCardType
    init(type: PostCardType, imageData: Data) {
        switch type {
        case .regular:
            showBackText = false
        case .foldable:
            showBackText = true
        }
        self.imageData = imageData
        self.cardType = type
    }
    
    func didClickOnNext() {
        navigateToPreviewIfDataIsValid()
    }
    
    private func navigateToPreviewIfDataIsValid() {
        if let errorMessage = getErrorMessageForInvalidData() {
            showAlert?("Error", errorMessage, "Ok", nil)
        } else {
            navigateToPreview()
        }
        
    }
    
    
    
    private func getErrorMessageForInvalidData() -> String? {
        
        if frontText == "" {
            return "Please add front text"
        } else if backText == "" && showBackText {
            return "Please add back text"
        } else if frontText.count > 30 {
            return "Front text should be maximum 30 characters"
        } else if backText.split(separator: " ").count > 30 {
            return "Back text should be maximum 30 words"
        }
        return  nil
    }
    
    private func navigateToPreview() {
        let backText: String? = self.backText == "" ? nil : self.backText
        let postCard = PostCard(imageData: imageData, frontText: frontText, backText: backText)
        let previewPostCardViewModel = PreviewPostCardViewModel(postCard: postCard)
        let previewPostCardViewController = PreviewPostCardViewController(viewModel: previewPostCardViewModel)
        pushViewController?(previewPostCardViewController, true
        )
    }
    
}
