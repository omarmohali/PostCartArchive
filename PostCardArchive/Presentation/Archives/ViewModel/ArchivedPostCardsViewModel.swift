//
//  ArchivedPostCardsViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import Foundation

class ArchivedPostCardsViewModel: ControllerViewModel {
    
    let archivedPostCards = ArchivedPostCards()
    
    private var allPostCards: [PostCard] {
        didSet {
            if let currentFilterType = currentFilterType {
                filterCards(type: currentFilterType)
            } else {
                filteredPostCards = allPostCards
            }
        }
    }
    
    var currentFilterType: PostCardType?
    var filteredPostCardsDidChange: (() -> Void)?
    var filteredPostCards: [PostCard] {
        didSet {
            filteredPostCardsDidChange?()
        }
    }
    
    override init() {
        allPostCards = archivedPostCards.getArchivedPostCards()
        filteredPostCards = allPostCards
        super.init()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: archivedPostCards.archivesChangedNotificationKey), object: nil, queue: nil, using: {
            [weak self] _ in
            guard let self = self else { return }
            self.allPostCards = self.archivedPostCards.getArchivedPostCards()
        })
    }
    
    func loadCard(at index: Int) {
        if index % 2 == 0 && index % 3 != 0 {
            showAlert?("Error", "Error while loading the post card", "Ok", nil)
        } else {
            let postCard = filteredPostCards[index]
            let previewPostCardViewModel = PreviewPostCardViewModel(postCard: postCard)
            let previewPostCardViewController = PreviewPostCardViewController(viewModel: previewPostCardViewModel)
            presentViewController?(previewPostCardViewController, true, nil)
        }
        
    }
    
    func syncCard(at index: Int) {
        showAlert?("", "Sync", "Ok", nil)
        
    }
    
    func deleteCard(at index: Int) {
        let postCard = filteredPostCards[index]
        archivedPostCards.delete(postCardId: postCard.id)
    }
    
    func filterCards(type: PostCardType?) {
        self.currentFilterType = type
        if let currentFilterType = self.currentFilterType {
            filteredPostCards = allPostCards.filter({$0.type == currentFilterType})
        } else {
            filteredPostCards = allPostCards
        }
        
    }
    
}
