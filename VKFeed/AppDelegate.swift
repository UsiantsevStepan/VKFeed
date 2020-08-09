//
//  AppDelegate.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 01.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthenticationManagerDelegate {
    
    func authenticationServiceShouldShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authenticationServiceSignIn() {
        let feedViewController = FeedViewController()
        window?.rootViewController = UINavigationController(rootViewController: feedViewController)
    }
    
    func authenticationServiceSignInFailed() {
    }
    
    var window: UIWindow?
    
    var authenticationService: AuthorizationManager!
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        authenticationService = AuthorizationManager()
        authenticationService.delegate = self
        
        window?.rootViewController = AuthorizationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: SDK Initialization
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey:Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
}

