//
//  NewsTextCell.swift
//  SocialWeb
//
//  Created by Никитка on 31.10.2021.
//

import UIKit

class NewsTextCell: UITableViewCell {
    static let identifier = "NewsTextCell"
    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myTextLabel)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myTextLabel.text = nil
    }
    
    private func setupCell() {
        NSLayoutConstraint.activate([
            myTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            myTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            myTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    public func configure(with text: String?) {
        myTextLabel.text = text
        myTextLabel.numberOfLines = 0
    }
}
