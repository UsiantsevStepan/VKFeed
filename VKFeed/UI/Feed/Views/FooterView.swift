//
//  FooterView.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 20.09.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import UIKit

class FooterView: UIView {
    private var postsAmountLabel = UILabel()
    private var pageActivityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureSubviews()
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
    
    func configureSubviews() {
        postsAmountLabel.textColor = .black
        postsAmountLabel.font = .boldSystemFont(ofSize: 16)
        postsAmountLabel.textAlignment = .center
        postsAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pageActivityIndicator.style = .gray
        pageActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showActivityIndicator() {
        pageActivityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        pageActivityIndicator.stopAnimating()
    }
    
    func set(title: String?) {
        hideActivityIndicator()
        postsAmountLabel.text = title
    }
    
    func clearLabel() {
        postsAmountLabel.text = nil
    }
}
