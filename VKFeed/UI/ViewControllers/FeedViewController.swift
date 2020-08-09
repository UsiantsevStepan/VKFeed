//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 03.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let tableView = UITableView()
    
    private let feedManager = FeedManager()
    private let cellId = "cellId"
    
    private var feedList = [PostCellModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
        
        feedManager.getFeedData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    return
                case let .success(data):
                    self.feedList = data
                }
            }
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(tableView)
        self.view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return friendsList.count
        return feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedTableViewCell
        let postUserLastName = feedList[indexPath.row].postUserLastName ?? ""
        let postUserFirstName = feedList[indexPath.row].postUserFirstName ?? ""
        let postUserFullName = postUserLastName + " " + postUserFirstName
        cell.postUser.text = postUserFullName
        
        cell.postLabel.text = feedList[indexPath.row].postText
        
        return cell
    }
}
