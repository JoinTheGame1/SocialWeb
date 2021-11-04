//
//  BottomButtonsCell.swift
//  SocialWeb
//
//  Created by Никитка on 02.11.2021.
//

import UIKit

class BottomButtonsCell: UITableViewCell {
    static let identifier = "BottomButtonsCell"
    
    private let likeButton: LikeButton = {
        let button = LikeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let commentButton: CommentButton = {
        let button = CommentButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let repostButton: RepostButton = {
        let button = RepostButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(repostButton)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 80),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            commentButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            commentButton.heightAnchor.constraint(equalToConstant: 30),
            commentButton.widthAnchor.constraint(equalToConstant: 80),
            commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            repostButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            repostButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 8),
            repostButton.heightAnchor.constraint(equalToConstant: 30),
            repostButton.widthAnchor.constraint(equalToConstant: 80),
            repostButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    public func configure(with like: TestLike, comments: Int, repost: TestRepost) {
        likeButton.configure(counter: like.likes, liked: like.liked)
        commentButton.configure(counter: comments)
        repostButton.configure(counter: repost.reposts, reposted: repost.reposted)
    }
}

class TestLike {
    let likes: Int
    let liked: Bool
    
    init(likes: Int, liked: Bool) {
        self.likes = likes
        self.liked = liked
    }
}

class TestRepost {
    let reposts: Int
    let reposted: Bool
    
    init(reposts: Int, reposted: Bool) {
        self.reposts = reposts
        self.reposted = reposted
    }
}
