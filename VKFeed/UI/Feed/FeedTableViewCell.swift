//
//  FeedTableViewCell.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 04.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    
    private var feedViewController = FeedViewController()
    private var stackView = UIStackView()
    private var userView = UIView()
    private var cellView = UIView()
    private var postTextView = UITextView()
    private var userLabel = UILabel()
    private var userPhoto = UIImageView(frame: .zero)
    
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
        userView.addSubview(userPhoto)
        stackView.addArrangedSubview(postTextView)
    }
    
    func setConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.topAnchor.constraint(equalTo: userView.topAnchor, constant: 5).isActive = true
        userPhoto.leadingAnchor.constraint(equalTo: userView.leadingAnchor, constant: 5).isActive = true
        userPhoto.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -5).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10).isActive = true
        userLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor, constant: -5).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 5).isActive = true
        
        
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
        
        userPhoto.layer.cornerRadius = Constants.imageSize / 2
        userPhoto.clipsToBounds = true
        
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
        
        userPhoto.kf.indicatorType = .activity
        userPhoto.kf.setImage(with: URL(string: postCellModel.postUserPhotoUrl ?? ""))
    }
}

private extension FeedTableViewCell {
    
    struct  Constants {
        static let imageSize: CGFloat = 50
    }
}
