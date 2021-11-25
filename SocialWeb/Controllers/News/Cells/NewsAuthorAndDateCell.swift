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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorNameLabel.text = nil
        dateLabel.text = nil
        authorAvatarImage.image = nil
    }
    
    private func setupCell() {
        let topConstraint = authorAvatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        NSLayoutConstraint.activate([
            topConstraint,
            authorAvatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            authorAvatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            authorAvatarImage.heightAnchor.constraint(equalToConstant: 50),
            authorAvatarImage.widthAnchor.constraint(equalToConstant: 50),
            
            authorNameLabel.topAnchor.constraint(equalTo: authorAvatarImage.topAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorAvatarImage.trailingAnchor, constant: 8),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: authorNameLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor)
        ])
        topConstraint.priority = .init(999)
    }
    
    public func configure(authorName: String, photoURL: String, date: String) {
        guard let url = URL(string: photoURL) else { return }
        authorNameLabel.text = authorName
        dateLabel.text = date
        authorAvatarImage.kf.setImage(with: url)
    }
}
