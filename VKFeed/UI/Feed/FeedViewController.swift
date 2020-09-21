//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 03.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate: class {
    func logout()
}

class FeedViewController: UIViewController {
    weak var delegate: FeedViewControllerDelegate!
    
    private var firstPageData = [PostCellModel]()
    private var userData: TitleViewModel?
    private var feedDataError: Error?
    private var userDataError: Error?
    private var feedList = [PostCellModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var nextFrom: String?
    private var isLoading = false
    private var refreshControl = UIRefreshControl()
    
    private let feedManager = FeedManager()
    private let titleView = TitleView()
    private let footerView = FooterView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = footerView
        
        navigationItem.titleView = titleView
        titleView.delegate = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        setupLayout()
        
        loadData()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        loadData()
        footerView.clearLabel()
    }
    
    private func loadData() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        
        group.enter()
        queue.async {
            self.feedManager.getFeedData() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .failure(error):
                    self.feedDataError = error
                    group.leave()
                case let .success(data):
                    self.firstPageData = data.0
                    self.nextFrom = data.1
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
                    self.userDataError = error
                    group.leave()
                case let .success(data):
                    self.userData = data
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            if let unwrappedFeedDataError = self.feedDataError {
                self.showError(unwrappedFeedDataError)
            } else if let unwrappedUserDataError = self.userDataError {
                self.showError(unwrappedUserDataError)
            }
            
            self.feedList = self.firstPageData
            guard let unwrappedUserData = self.userData else { return }
            self.titleView.configure(with: unwrappedUserData)
            self.refreshControl.endRefreshing()
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
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseID)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > 0,
            offsetY > contentHeight - scrollView.frame.height - 200 {
            loadNextPage()
        }
    }
    
    func loadNextPage() {
        if nextFrom == nil {
            footerView.set(title: "Amount of posts: \(feedList.count)")
        }
        
        if isLoading || nextFrom == nil { return }
        isLoading = true
        footerView.showActivityIndicator()
        
        DispatchQueue.global(qos: .background).async {
            self.feedManager.getFeedData(self.nextFrom) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case let .failure(error):
                        self.showError(error)
                    case let .success(data):
                        self.nextFrom = data.1
                        self.feedList += data.0
                    }
                    self.isLoading = false
                    self.footerView.hideActivityIndicator()
                }
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as! FeedTableViewCell
        cell.configure(with: feedList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    
}

extension FeedViewController: TitleViewDelegate {
    func logout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { [delegate] (_) in
            delegate?.logout()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
