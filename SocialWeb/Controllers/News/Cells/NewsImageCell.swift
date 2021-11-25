//
//  NewsImageCell.swift
//  SocialWeb
//
//  Created by Никитка on 01.11.2021.
//

import UIKit
import Kingfisher

class NewsImageCell: UITableViewCell {
    static let identifier = "NewsImageCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myImageView)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    private func setupCell (){
        let topConstraint = myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        NSLayoutConstraint.activate([
            topConstraint,
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        topConstraint.priority = .init(999)
    }
    
    func configure(with image: String) {
        guard let url = URL(string: image) else { return }
        myImageView.kf.setImage(with: url)
    }
}
