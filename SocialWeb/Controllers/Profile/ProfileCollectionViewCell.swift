//
//  ProfileCollectionViewCell.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    private let photoImageView: UIImageView = {
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
        contentView.addSubview(photoImageView)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            likeButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            likeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        setupCell()
    }
    
    private func setupCell() {
        photoImageView.layer.cornerRadius = photoImageView.frame.size.height / 2
        photoImageView.layer.backgroundColor = UIColor.white.cgColor
        photoImageView.layer.borderWidth = 2
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.clipsToBounds = true
    }

    func configure(_ photo: Photo) {
        guard let url = URL(string: photo.sizes.last!.url) else { return }
        photoImageView.kf.setImage(with: url)
        let liked = photo.likes?.liked ?? false
        likeButton.configure(counter: photo.likes?.count ?? 0, liked: liked)
    }
    
}
