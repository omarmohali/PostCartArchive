//
//  ChoosePostCardTypeViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class ChoosePostCardTypeViewModel: ControllerViewModel {
    
    var postCardType: PostCardType?
    
    func didClickOnRegularCard() {
        postCardType = .regular
    }
    
    func didClickOnFoldableCard() {
        postCardType = .foldable
    }
    
    func didChooseImage(_ imageData: Data) {
        
        guard let postCardType = postCardType else { return }
        
        let addPostCardTextViewModel = AddPostCardTextViewModel(type: postCardType, imageData: imageData)
        let addPostCardImageViewController = AddPostCardTextViewController(viewModel: addPostCardTextViewModel)
        pushViewController?(addPostCardImageViewController, true)
    }
    
}
