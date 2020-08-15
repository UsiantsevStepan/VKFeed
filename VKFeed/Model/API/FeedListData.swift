//
//  FeedListData.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation

struct FeedListData: Codable {
    let response: Response
}

struct Response: Codable {
    let items: [Item]
    let profiles: [Profile]
}

struct Item: Codable {
    let sourceId: Int
    let text: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case text
        case date
    }
}

struct Profile: Codable {
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
