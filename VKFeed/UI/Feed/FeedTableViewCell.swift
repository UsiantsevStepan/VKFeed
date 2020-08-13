//
//  FeedTableViewCell.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    private var feedViewController = FeedViewController()
    private var stackView = UIStackView()
    private var userView = UIView()
    private var cellView = UIView()

    var userLabel = UILabel()

    var postTextView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        configureSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubviews() {
        self.addSubview(cellView)
        cellView.addSubview(stackView)
        stackView.addArrangedSubview(userView)
        userView.addSubview(userLabel)
        stackView.addArrangedSubview(postTextView)
    }
    
    func setConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.topAnchor.constraint(equalTo: userView.topAnchor).isActive = true
        userLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor, constant: 0).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: userView.leadingAnchor, constant: 0).isActive = true
        userLabel.bottomAnchor.constraint(equalTo: userView.bottomAnchor).isActive = true
        
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        postTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
        postTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5).isActive = true
    }
    
    func configureSubviews() {
        cellView.backgroundColor = UIColor.white
        cellView.layer.cornerRadius = 5
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowRadius = 3.5
        cellView.layer.shadowOpacity = 0.15
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.frame = cellView.bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        userLabel.font = UIFont.systemFont(ofSize: 20)
        
        postTextView.font = UIFont.systemFont(ofSize: 15)
        postTextView.isEditable = false
        postTextView.isScrollEnabled = false
        postTextView.isUserInteractionEnabled = true
        postTextView.isSelectable = true
        let padding = postTextView.textContainer.lineFragmentPadding
        postTextView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        postTextView.dataDetectorTypes = .all
    }
    
    func configure(with postCellModel: PostCellModel) {
        let postUserLastName = postCellModel.postUserLastName ?? ""
        let postUserFirstName = postCellModel.postUserFirstName ?? ""
        let postUserFullName = postUserLastName + " " + postUserFirstName
        userLabel.text = postUserFullName
        
        postTextView.isHidden = (postCellModel.postText ?? "").isEmpty
        postTextView.text = postCellModel.postText
    }
}
