//
//  FeedListData.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation

struct FeedListData: Decodable {
    let response: Response
}

struct Response: Decodable {
    let items: [Item]
    let profiles: [Profile]
}

struct Item: Decodable {
    let sourceId: Int
    let text: String
    let date: Date
    let attachments: [Attachments]?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case text
        case date
        case attachments
    }
}

struct Attachments: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [Size]
    
    var necessarySize: Size? {
        guard let size = sizes.first(where: {$0.type == .x}) else { return sizes.last }
        return size
    }
    
}

struct Size: Decodable {
    let url: String
    let type: PhotoSizeType
    
}

enum PhotoSizeType: String, Decodable {
    case s, m, x, o, p, q, r, y, z, w
}

struct Profile: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let userPhotoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userPhotoUrl = "photo_100"
    }
}

