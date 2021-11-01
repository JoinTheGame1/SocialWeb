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
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myTextLabel.frame = CGRect(x: 5, y: 5, width: contentView.frame.width - 10, height: contentView.frame.height - 10)
    }
    
    public func configure(with text: String) {
        contentView.addSubview(myTextLabel)
        var content = self.defaultContentConfiguration()
        content.text = text
        self.contentConfiguration = content
    }
}
