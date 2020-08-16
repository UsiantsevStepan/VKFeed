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
        userView.addSubview(userNameLabel)
        userView.addSubview(userPhotoImageView)
        userView.addSubview(dateLabel)
        stackView.addArrangedSubview(textView)
        
        stackView.addArrangedSubview(collectionView)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.cellId)
    }
    
    func setConstraints() {
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
        userPhotoImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        userPhotoImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        
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
        
        userPhotoImageView.layer.cornerRadius = Constants.imageSize / 2
        userPhotoImageView.clipsToBounds = true
        
        userNameLabel.font = UIFont.systemFont(ofSize: 20)
        
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
        static let imageSize: CGFloat = 50
    }
}
