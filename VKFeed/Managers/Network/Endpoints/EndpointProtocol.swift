//
//  EndpointProtocol.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol EndpointProtocol {
    var baseURL: String { get }
    var fullURL: String { get }
    var params: [String : String] { get }
}

extension EndpointProtocol {
    var accessToken: String {
        return VKSdk.accessToken()?.accessToken ?? ""
    }
    var apiVersion: String {
        return "5.122"
    }
    var userId: String {
        return VKSdk.accessToken()?.userId ?? ""
    }
    var filters: String {
        return "post"
    }
    var sourceIds: String {
        return "friends"
    }
    
}
