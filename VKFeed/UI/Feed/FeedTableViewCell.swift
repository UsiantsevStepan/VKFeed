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
    
    var postUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var postLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSubviews() {
        self.addSubview(postUser)
        self.addSubview(postLabel)
    }
    
    private func setupConstraints() {
        postUser.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        postUser.heightAnchor.constraint(equalToConstant: 40).isActive = true
        postUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        postUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        
        postLabel.topAnchor.constraint(equalTo: postUser.bottomAnchor, constant: 15).isActive = true
        postLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        postLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        postLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
    }
}
