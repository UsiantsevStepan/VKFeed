//
//  ViewController.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 01.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private var authenticationService: AuthorizationManager = AppDelegate.shared.authenticationService
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonAction(sender:)), for: .touchUpInside )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(ciColor: .white)
        
        view.addSubview(loginButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    @objc func loginButtonAction(sender: UIButton) {
        authenticationService.wakeUpSession()
    }
}

