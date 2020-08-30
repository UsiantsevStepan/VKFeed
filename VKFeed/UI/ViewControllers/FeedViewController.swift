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
        
        feedManager.getFeedData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    self.showError(error)
                case let .success(data):
                    self.feedList = data
                }
            }
        }
        
        feedManager.getUserData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    self.showError(error)
                case let .success(userData):
                    self.titleView.configure(with: userData)
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
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
