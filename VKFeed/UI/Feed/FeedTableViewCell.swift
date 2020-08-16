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

class FeedTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    private var feedViewController = FeedViewController()
    private var cellView = UIView()
    private var stackView = UIStackView()
    private var userView = UIView()
    private var userPhoto = UIImageView(frame: .zero)
    private var userLabel = UILabel()
    private var postDateLabel = UILabel()
    private var postTextView = UITextView()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private let collectionCellId = "collectionCellId"
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! FeedCollectionViewCell
        let attachedPhoto = photos[indexPath.row]
        cell.attachedPhoto.kf.indicatorType = .activity
        cell.attachedPhoto.kf.setImage(with: URL(string: attachedPhoto))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if photos.count == 1 {
            return collectionView.frame.size
        } else {
            return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
    }
    
    func addSubviews() {
        self.addSubview(cellView)
        cellView.addSubview(stackView)
        stackView.addArrangedSubview(userView)
        userView.addSubview(userLabel)
        userView.addSubview(userPhoto)
        userView.addSubview(postDateLabel)
        stackView.addArrangedSubview(postTextView)
        
        stackView.addArrangedSubview(collectionView)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
    }
    
    func setConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.topAnchor.constraint(equalTo: userView.topAnchor, constant: 5).isActive = true
        userPhoto.leadingAnchor.constraint(equalTo: userView.leadingAnchor).isActive = true
        userPhoto.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -5).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.topAnchor.constraint(equalTo: userView.topAnchor, constant: 5).isActive = true
        userLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 5).isActive = true
        
        postDateLabel.translatesAutoresizingMaskIntoConstraints = false
        postDateLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor).isActive = true
        postDateLabel.leadingAnchor.constraint(equalTo: userPhoto.trailingAnchor, constant: 5).isActive = true
        postDateLabel.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -10).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
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
        
        postDateLabel.font = UIFont.systemFont(ofSize: 15)
        postDateLabel.textColor = .gray
        
        postTextView.font = UIFont.systemFont(ofSize: 15)
        postTextView.isEditable = false
        postTextView.isScrollEnabled = false
        postTextView.isUserInteractionEnabled = true
        postTextView.isSelectable = true
        let padding = postTextView.textContainer.lineFragmentPadding
        postTextView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        postTextView.dataDetectorTypes = .all
        
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func configure(with postCellModel: PostCellModel) {
        
        userLabel.text = postCellModel.userName
        
        postDateLabel.text = postCellModel.date
        
        postTextView.isHidden = (postCellModel.text ?? "").isEmpty
        postTextView.text = postCellModel.text
        
        userPhoto.kf.indicatorType = .activity
        userPhoto.kf.setImage(with: URL(string: postCellModel.userPhotoUrl ?? ""))
        
        photos = postCellModel.photos ?? []
        collectionView.isHidden = photos.isEmpty
    }
}

private extension FeedTableViewCell {
    
    struct Constants {
        static let imageSize: CGFloat = 50
    }
}
