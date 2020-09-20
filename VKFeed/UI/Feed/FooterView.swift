//
//  FooterView.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 20.09.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit

class FooterView: UIView {
    private var postsAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pageActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubviews() {
        addSubview(postsAmountLabel)
        addSubview(pageActivityIndicator)
    }
    
    func setConstraints() {
        postsAmountLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        postsAmountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        pageActivityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        pageActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func showActivityIndicator() {
        pageActivityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        pageActivityIndicator.stopAnimating()
    }
    
    func set(title: String?) {
        pageActivityIndicator.stopAnimating()
        postsAmountLabel.text = title
    }
    
    func clearLabel() {
        postsAmountLabel.text = nil
    }
}
