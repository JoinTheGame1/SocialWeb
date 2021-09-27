//
//  ProfileCollectionViewCell.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let likeButton: LikeButton = {
        let likeButton = LikeButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        return likeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileImageView)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            likeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        setupCell()
    }
    
    private func setupCell() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.layer.backgroundColor = UIColor.white.cgColor
        profileImageView.layer.shadowColor = UIColor.darkGray.cgColor
        profileImageView.layer.shadowRadius =  8
        profileImageView.layer.shadowOpacity = 0.8
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.clipsToBounds = true
    }

    func configure() {
        profileImageView.image = UIImage(named: "me")
    }
    
}
