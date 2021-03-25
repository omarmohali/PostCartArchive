//
//  PostCard.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

class PostCard: Codable {
    
    let id: String
    let imageData: Data
    let frontText: String
    let backText: String?
    
    var type: PostCardType {
        if backText == nil {
            return .regular
        } else {
            return .foldable
        }
    }
    
    init(imageData: Data, frontText: String, backText: String?) {
        self.id = UUID().uuidString
        self.imageData = imageData
        self.frontText = frontText
        self.backText = backText
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageData
        case frontText
        case backText
    }
    
}


enum PostCardType {
    case regular
    case foldable
}

