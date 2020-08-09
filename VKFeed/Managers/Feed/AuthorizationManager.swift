//
//  AuthorizationManager.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 02.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthenticationManagerDelegate: class {
    func authenticationServiceShouldShow(_ viewController: UIViewController)
    func authenticationServiceSignIn()
    func authenticationServiceSignInFailed()
}

class AuthorizationManager: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let vkSDK: VKSdk
    private var appId = "7555630"
    
    weak var delegate: AuthenticationManagerDelegate?
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appId)
        
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authenticationServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authenticationServiceSignInFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authenticationServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func wakeUpSession() {
        let scope: [String] = ["wall","friends"]
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == .authorized {
                print("authorized")
                delegate?.authenticationServiceSignIn()
            } else if state == .initialized {
                VKSdk.authorize(scope)
            } else {
                print("Auth problem, state: \(state), error: \(error?.localizedDescription ?? "")")
                delegate?.authenticationServiceSignInFailed()
            }
        }
    }
    
}
