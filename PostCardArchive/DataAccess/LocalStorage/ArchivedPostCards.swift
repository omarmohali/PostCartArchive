//
//  ArchivedPostCards.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class ArchivedPostCards {
    
    let archivedCardsKey = "archivedCardsKey"
    let archivesChangedNotificationKey = "archivesChangedNotificationKey"
    
    var numberOfSavedPostCards: Int {
        return getArchivedPostCards().count
    }
    
    func save(postCard: PostCard) {
        var postCards = getArchivedPostCards()
        postCards.removeAll(where: {$0.id == postCard.id})
        postCards = [postCard] + postCards
        if let data = try? JSONEncoder().encode(postCards) {
            UserDefaults.standard.setValue(data, forKey: archivedCardsKey)
        }
        fireArchivesChangedNotification()
    }
    
    func getArchivedPostCards() -> [PostCard] {
        guard let data = UserDefaults.standard.object(forKey: archivedCardsKey) as? Data else { return []}
        if let postCards = try? JSONDecoder().decode([PostCard].self, from: data) {
            return postCards
        } else {
            return []
        }
    }
    
    func delete(postCardId: String) {
        var postCards = getArchivedPostCards()
        postCards.removeAll(where: {$0.id == postCardId})
        if let data = try? JSONEncoder().encode(postCards) {
            UserDefaults.standard.setValue(data, forKey: archivedCardsKey)
        }
        fireArchivesChangedNotification()
    }
    
    private func fireArchivesChangedNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: archivesChangedNotificationKey), object: nil, userInfo: nil)
    }
    
}
