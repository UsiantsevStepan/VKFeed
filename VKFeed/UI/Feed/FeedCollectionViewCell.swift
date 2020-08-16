//
//  FeedCollectionViewCell.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 16.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    var attachedPhoto = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstrainst()
        configureSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(attachedPhoto)
        
    }
    
    func setConstrainst() {
        attachedPhoto.translatesAutoresizingMaskIntoConstraints = false
        attachedPhoto.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        attachedPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        attachedPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        attachedPhoto.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func configureSubviews() {
        attachedPhoto.contentMode = .scaleAspectFill
    }
}
