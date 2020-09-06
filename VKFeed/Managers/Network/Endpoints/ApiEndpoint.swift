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
    case getUser
    case feedList(nextFrom: String?)
}

extension VkApi: EndpointProtocol {
    var baseURL: String {
        return "https://api.vk.com/method"
    }
    
    var fullURL: String {
        switch self {
        case .getUser:
            return baseURL + "/users.get"
        case .feedList:
            return baseURL + "/newsfeed.get"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .getUser:
            return ["access_token": accessToken, "v": apiVersion, "fields": "photo_100"]
        case let .feedList(nextFrom):
            var params = ["user_id": userId, "access_token": accessToken, "v": apiVersion, "filters": "post", "source_ids": "friends"]
            if let nextFrom = nextFrom {
                params["start_from"] = nextFrom
            }
            return params
        }
    }
}
