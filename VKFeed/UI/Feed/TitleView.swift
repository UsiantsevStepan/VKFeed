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

protocol TitleViewDelegate: class {
    func logout()
}

class TitleView: UIView {
    weak var delegate: TitleViewDelegate!
    
    private let label = UILabel()
    private var userPictureButton = UIButton()
    
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
        self.addSubview(userPictureButton)
    }
    
    func setConstraints() {
        userPictureButton.translatesAutoresizingMaskIntoConstraints = false
        userPictureButton.heightAnchor.constraint(equalToConstant: Constants.userImageSize).isActive = true
        userPictureButton.widthAnchor.constraint(equalToConstant: Constants.userImageSize).isActive = true
        userPictureButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userPictureButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: userPictureButton.leadingAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0).isActive = true
    }
    
    func configureSubviews() {
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        userPictureButton.contentMode = .scaleAspectFill
        userPictureButton.layer.cornerRadius = Constants.userImageSize / 2
        userPictureButton.layer.masksToBounds = true
        userPictureButton.clipsToBounds = true
        userPictureButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    func configure(with userModel: TitleViewModel) {
        label.text = userModel.userName
    
        userPictureButton.kf.setImage(with: URL(string: userModel.userPhotoUrl ?? ""), for: .normal)
    }
    
    @objc func logout(_ sender: UIButton) {
        delegate.logout()
    }
}

private extension TitleView {
    
    struct Constants {
        static let userImageSize: CGFloat = 40
    }
}
