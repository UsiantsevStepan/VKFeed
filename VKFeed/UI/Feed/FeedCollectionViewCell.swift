//
//  FeedCollectionViewCell.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 16.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FeedCollectionViewCell: UICollectionViewCell {

    static let cellId = "PhotoCollectionViewCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstrainst()
        configureSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with photoUrl: String) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: photoUrl),
                              placeholder: #imageLiteral(resourceName: "search"))
        
    }
    
    func addSubviews() {
        self.addSubview(imageView)
        
    }
    
    func setConstrainst() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func configureSubviews() {
        imageView.contentMode = .scaleAspectFill
    }
}
