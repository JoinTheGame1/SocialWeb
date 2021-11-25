//
//  NewsTextCell.swift
//  SocialWeb
//
//  Created by Никитка on 31.10.2021.
//

import UIKit

class NewsTextCell: UITableViewCell {
    static let identifier = "NewsTextCell"
    
    private var isLabelAtMaxHeight = false
    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let showMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show more", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myTextLabel)
        contentView.addSubview(showMoreButton)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myTextLabel.text = nil
    }
    
    @objc func onTap(_ sender: UIButton) {
        if isLabelAtMaxHeight {
            showMoreButton.setTitle("Show less", for: .normal)
            isLabelAtMaxHeight = false
        }
        else {
            showMoreButton.setTitle("Show more", for: .normal)
            isLabelAtMaxHeight = true
        }
    }
    
    private func setupCell() {
        let labelTopConstraint = myTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        NSLayoutConstraint.activate([
            labelTopConstraint,
            myTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            myTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            showMoreButton.topAnchor.constraint(equalTo: myTextLabel.topAnchor),
            showMoreButton.leadingAnchor.constraint(equalTo: myTextLabel.trailingAnchor, constant: 4),
            showMoreButton.bottomAnchor.constraint(equalTo: myTextLabel.bottomAnchor)
        ])
        labelTopConstraint.priority = .init(999)
    }
    
    public func configure(with text: String?) {
        myTextLabel.text = text
    }
}
