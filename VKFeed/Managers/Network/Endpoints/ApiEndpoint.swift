//
//  ApiEndpoint.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import VK_ios_sdk

public enum VkApi {
    case friendsList
    case feedList
}

extension VkApi: EndpointProtocol {
    var baseURL: String {
        return "https://api.vk.com/method"
    }
    
    var fullURL: String {
        switch self {
        case .friendsList:
            return baseURL + "/friends.get"
        case .feedList:
            return baseURL + "/newsfeed.get"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .friendsList:
            return ["user_id": userId, "access_token": accessToken, "v": apiVersion, "filters": filters, "source_ids": sourceIds]
        case .feedList:
            return ["user_id": userId, "access_token": accessToken, "v": apiVersion, "filters": filters, "source_ids": sourceIds]
        }
    }
}
