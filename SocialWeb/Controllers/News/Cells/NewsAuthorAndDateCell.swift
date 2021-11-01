//
//  NewsAuthorAndDateCell.swift
//  SocialWeb
//
//  Created by Никитка on 01.11.2021.
//

import UIKit

class NewsAuthorAndDateCell: UITableViewCell {
    static let identifier = "NewsAuthorAndDateCell"
    
    private let authorAvatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(authorAvatarImage)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(dateLabel)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        NSLayoutConstraint.activate([
            authorAvatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            authorAvatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorAvatarImage.heightAnchor.constraint(equalToConstant: 50),
            authorAvatarImage.widthAnchor.constraint(equalToConstant: 50),
            
            authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorAvatarImage.trailingAnchor, constant: 8),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor)
        ])
    }
    
    public func configure(with authorName: String, date: String) {
        authorNameLabel.text = authorName
        dateLabel.text = date
    }
}
