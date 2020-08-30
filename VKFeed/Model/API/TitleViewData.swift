//
//  TitleViewData.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 30.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation

struct TitleViewData: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let firstName: String?
    let lastName: String?
    let userPhotoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userPhotoUrl = "photo_100"
    }
}
