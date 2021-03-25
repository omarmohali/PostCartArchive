//
//  ViewModel.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation
import UIKit

class MainViewModel: ControllerViewModel {
    
    let archivedPostCards = ArchivedPostCards()
    
    var numberOfArchivesButtonTextDidChange: (() -> Void)?
    var numberOfArchivesButtonText: String {
        didSet {
            numberOfArchivesButtonTextDidChange?()
        }
    }
    
    override init() {
        numberOfArchivesButtonText = "Archives (\(archivedPostCards.numberOfSavedPostCards))"
        super.init()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: archivedPostCards.archivesChangedNotificationKey), object: nil, queue: nil, using: {
            [weak self] _ in
            guard let self = self else { return }
            self.numberOfArchivesButtonText = "Archives (\(self.archivedPostCards.numberOfSavedPostCards))"
        })
    }
    
    func didClickOnCreateCard() {
        let choosePostCardTypeViewModel = ChoosePostCardTypeViewModel()
        let choosePostCardTypeViewController = ChoosePostCardTypeViewController(viewModel: choosePostCardTypeViewModel)
        let navigationController = UINavigationController(rootViewController: choosePostCardTypeViewController)
        presentViewController?(navigationController, true, nil)
    }
    
    func didClickOnViewArchives() {
        let archivedPostCardsViewModel = ArchivedPostCardsViewModel()
        let archivedPostCardsViewController = ArchivedPostCardsViewController(viewModel: archivedPostCardsViewModel)
        let navigationController = UINavigationController(rootViewController: archivedPostCardsViewController)
        presentViewController?(navigationController, true, nil)
    }
    
}
