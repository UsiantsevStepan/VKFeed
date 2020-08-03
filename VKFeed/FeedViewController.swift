//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 03.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feedViewController = UIViewController()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        
        self.view.addSubview(tableView)
        
    }
 
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}
