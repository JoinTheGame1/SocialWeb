//
//  FriendCollectionViewCell.swift
//  SocialWeb
//
//  Created by Никитка on 24.07.2021.
//

import UIKit
import Kingfisher

class FriendCollectionViewCell: UICollectionViewCell {
    static let identifier = "FriendCollectionViewCell"
    
    private let friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let friendImageShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likeButton: LikeButton = {
        let likeButton = LikeButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        return likeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(friendImageShadowView)
        friendImageShadowView.addSubview(friendImageView)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            friendImageShadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            friendImageShadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            friendImageShadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            friendImageView.topAnchor.constraint(equalTo: friendImageShadowView.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: friendImageShadowView.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: friendImageShadowView.trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: friendImageShadowView.bottomAnchor),
            
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: friendImageShadowView.bottomAnchor, constant: 8),
            likeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        setupCell()
    }
    
    private func setupCell() {
        friendImageShadowView.layer.cornerRadius = friendImageShadowView.frame.size.height / 2
        friendImageShadowView.layer.backgroundColor = UIColor.white.cgColor
        friendImageShadowView.layer.shadowColor = UIColor.darkGray.cgColor
        friendImageShadowView.layer.shadowRadius =  8
        friendImageShadowView.layer.shadowOpacity = 0.8
        friendImageShadowView.layer.borderWidth = 2
        friendImageShadowView.layer.borderColor = UIColor.black.cgColor
        friendImageView.layer.cornerRadius = friendImageView.frame.size.height / 2
        friendImageView.clipsToBounds = true
    }

    func configure(_ photo: Photo) {
        let url = URL(string: photo.sizes.last!.url)
        friendImageView.kf.setImage(with: url)
        let liked = photo.likes?.liked ?? false
        likeButton.configure(counter: photo.likes?.count ?? 0, liked: liked)
    }
}
