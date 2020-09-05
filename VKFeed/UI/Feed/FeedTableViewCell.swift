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
    
    private var postView = UIView()
    
    private var stackView = UIStackView()
    
    private var userView = UIView()
    private var userPhotoImageView = UIImageView(frame: .zero)
    private var userNameLabel = UILabel()
    private var dateLabel = UILabel()
    private var textView = UITextView()
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    private let postFooterView = UIView()
    private let likesImageView = UIImageView(image: #imageLiteral(resourceName: "like"))
    private let likesAmountLabel = UILabel()
    private let commentsImageView = UIImageView(image: #imageLiteral(resourceName: "comment"))
    private let commentsAmountLabel = UILabel()
    private let repostsImageView = UIImageView(image: #imageLiteral(resourceName: "share"))
    private let repostsAmountLabel = UILabel()
    private let viewsImageView = UIImageView(image: #imageLiteral(resourceName: "eye"))
    private let viewsAmountLabel = UILabel()
    
    private var photos = [String]()
    
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
        self.addSubview(postView)
        postView.addSubview(stackView)
        stackView.addArrangedSubview(userView)
        [userNameLabel, userPhotoImageView, dateLabel].forEach(userView.addSubview)
        
        stackView.addArrangedSubview(textView)
        
        
        stackView.addArrangedSubview(collectionView)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.cellId)
        
        stackView.addArrangedSubview(postFooterView)
        [likesImageView, likesAmountLabel, commentsImageView, commentsAmountLabel, repostsImageView, repostsAmountLabel, viewsImageView, viewsAmountLabel].forEach(postFooterView.addSubview)
    }
    
    func setConstraints() {
        likesImageView.translatesAutoresizingMaskIntoConstraints = false
        likesImageView.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        likesImageView.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        likesImageView.leadingAnchor.constraint(equalTo: postFooterView.leadingAnchor).isActive = true
        likesImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageSize).isActive = true
        
        likesAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        likesAmountLabel.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        likesAmountLabel.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        likesAmountLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: 4).isActive = true
        likesAmountLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        commentsImageView.translatesAutoresizingMaskIntoConstraints = false
        commentsImageView.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        commentsImageView.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        commentsImageView.leadingAnchor.constraint(equalTo: likesAmountLabel.trailingAnchor, constant: 8).isActive = true
        commentsImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageSize).isActive = true
        
        commentsAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsAmountLabel.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        commentsAmountLabel.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        commentsAmountLabel.leadingAnchor.constraint(equalTo: commentsImageView.trailingAnchor, constant: 4).isActive = true
        commentsAmountLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        repostsImageView.translatesAutoresizingMaskIntoConstraints = false
        repostsImageView.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        repostsImageView.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        repostsImageView.leadingAnchor.constraint(equalTo: commentsAmountLabel.trailingAnchor, constant: 8).isActive = true
        repostsImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageSize).isActive = true
        
        repostsAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        repostsAmountLabel.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        repostsAmountLabel.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        repostsAmountLabel.leadingAnchor.constraint(equalTo: repostsImageView.trailingAnchor, constant: 4).isActive = true
        repostsAmountLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewsImageView.translatesAutoresizingMaskIntoConstraints = false
        viewsImageView.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        viewsImageView.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        viewsImageView.trailingAnchor.constraint(equalTo: viewsAmountLabel.leadingAnchor, constant: -4).isActive = true
        viewsImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageSize).isActive = true
        
        viewsAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsAmountLabel.topAnchor.constraint(equalTo: postFooterView.topAnchor, constant: 5).isActive = true
        viewsAmountLabel.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor).isActive = true
        viewsAmountLabel.trailingAnchor.constraint(equalTo: postFooterView.trailingAnchor).isActive = true
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        postView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        postView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        postView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        postView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: postView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 10).isActive = true
        
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 5).isActive = true
        userPhotoImageView.leadingAnchor.constraint(equalTo: userView.leadingAnchor).isActive = true
        userPhotoImageView.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -5).isActive = true
        userPhotoImageView.heightAnchor.constraint(equalToConstant: Constants.userImageSize).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: Constants.userImageSize).isActive = true
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: userView.topAnchor, constant: 5).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -10).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func configureSubviews() {
        postView.backgroundColor = UIColor.white
        postView.layer.cornerRadius = 5
        postView.layer.shadowOffset = .zero
        postView.layer.shadowColor = UIColor.black.cgColor
        postView.layer.shadowRadius = 3.5
        postView.layer.shadowOpacity = 0.15
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.frame = postView.bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        userPhotoImageView.layer.cornerRadius = Constants.userImageSize / 2
        userPhotoImageView.clipsToBounds = true
        
        userNameLabel.font = UIFont.systemFont(ofSize: 20)
        
        likesImageView.contentMode = .scaleAspectFill
        
        likesAmountLabel.font = UIFont.systemFont(ofSize: 14)
        likesAmountLabel.textColor = .gray
        
        commentsImageView.contentMode = .scaleAspectFill
        
        commentsAmountLabel.font = UIFont.systemFont(ofSize: 14)
        commentsAmountLabel.textColor = .gray
        
        repostsImageView.contentMode = .scaleAspectFill
        
        repostsAmountLabel.font = UIFont.systemFont(ofSize: 14)
        repostsAmountLabel.textColor = .gray
        
        viewsImageView.contentMode = .scaleAspectFill
        
        viewsAmountLabel.font = UIFont.systemFont(ofSize: 14)
        viewsAmountLabel.textColor = .gray
        
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = .gray
        
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        textView.dataDetectorTypes = .all
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func configure(with postCellModel: PostCellModel) {
        
        userNameLabel.text = postCellModel.userName
        
        dateLabel.text = postCellModel.date
        
        likesAmountLabel.text = postCellModel.likes
        commentsAmountLabel.text = postCellModel.comments
        repostsAmountLabel.text = postCellModel.reposts
        viewsAmountLabel.text = postCellModel.views
        
        textView.isHidden = (postCellModel.text ?? "").isEmpty
        textView.text = postCellModel.text
        
        userPhotoImageView.kf.indicatorType = .activity
        userPhotoImageView.kf.setImage(with: URL(string: postCellModel.userPhotoUrl ?? ""))
        
        photos = postCellModel.photos ?? []
        collectionView.isHidden = photos.isEmpty
    }
}

extension FeedTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.cellId, for: indexPath) as! FeedCollectionViewCell
        cell.configure(with: photos[indexPath.row])
        return cell
    }
}

extension FeedTableViewCell: UICollectionViewDelegate {
    
}

extension FeedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if photos.count == 1 {
            return collectionView.frame.size
        } else {
            return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
    }
}


private extension FeedTableViewCell {
    
    struct Constants {
        static let userImageSize: CGFloat = 50
        static let iconImageSize: CGFloat = 16
    }
}
