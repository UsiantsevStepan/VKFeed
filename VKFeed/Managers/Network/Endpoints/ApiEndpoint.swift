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
    case getFeed(nextFrom: String?)
}

extension VkApi: EndpointProtocol {
    var baseURL: String {
        return "https://api.vk.com"
    }
    
    var fullURL: String {
        switch self {
        case .getUser:
            return baseURL + "/method/users.get"
        case .getFeed:
            return baseURL + "/method/newsfeed.get"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .getUser:
            return [
                "access_token": accessToken,
                "v": apiVersion,
                "fields": "photo_100"
            ]
            
        case let .getFeed(nextFrom):
            var params = [
                "access_token": accessToken,
                "v": apiVersion,
                "filters": "post"
            ]
            
            if let nextFrom = nextFrom {
                params["start_from"] = nextFrom
            }
            
            return params
        }
    }
}
