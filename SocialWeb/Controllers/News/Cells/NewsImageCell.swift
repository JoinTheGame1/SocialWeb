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
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
    
    private func setupImageView (){
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with image: Photo?) {
        guard let url = URL(string: image?.sizes.last?.url ?? "") else { return }
        myImageView.kf.setImage(with: url)
        
    }
}
