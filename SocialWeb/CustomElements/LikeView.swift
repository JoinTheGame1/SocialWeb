//
//  LikeView.swift
//  SocialWeb
//
//  Created by Никитка on 03.11.2021.
//

import UIKit

class LikeView: UIView {
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let likesCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setNeedsDisplay()
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 4)
        
        
        ])
    }
}
