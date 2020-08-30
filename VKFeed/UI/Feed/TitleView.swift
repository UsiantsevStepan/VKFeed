//
//  TitleView.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 30.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class TitleView: UIView {
    
    private let label = UILabel()
    private let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func addSubviews() {
        self.addSubview(label)
        self.addSubview(button)
    }
    
    func setConstraints() {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: Constants.userImageSize).isActive = true
        button.widthAnchor.constraint(equalToConstant: Constants.userImageSize).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0).isActive = true

    }
    
    func configureSubviews() {
        
//        label.font = UIFont.boldSystemFont(ofSize: )
        
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.layer.cornerRadius = Constants.userImageSize / 2
        button.imageView?.clipsToBounds = true
        
    }
    
    func configure(with userModel: TitleViewModel) {
        label.text = userModel.userName
    
        button.kf.setImage(with: URL(string: userModel.userPhotoUrl ?? ""), for: .normal)
    }
}

private extension TitleView {
    
    struct Constants {
        static let userImageSize: CGFloat = 40
    }
}
