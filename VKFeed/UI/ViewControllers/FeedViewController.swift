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
    private let tableCellId = "cellId"
    private let titleView = TitleView()
    
    var feedList = [PostCellModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.titleView = titleView
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        setupLayout()
        
        loadData()
    }
    
    private func loadData() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        
        var feedData = [PostCellModel]()
        var userData: TitleViewModel?
        
        group.enter()
        queue.async {
            self.feedManager.getFeedData { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    self.showError(error)
                    group.leave()
                case let .success(data):
                    feedData = data
                    group.leave()
                }
            }
        }
        
        group.enter()
        queue.async {
            self.feedManager.getUserData { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    self.showError(error)
                    group.leave()
                case let .success(data):
                    userData = data
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.feedList = feedData
            guard let unwrappedUserData = userData else { return }
            self.titleView.configure(with: unwrappedUserData)
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
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! FeedTableViewCell
        cell.configure(with: feedList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
