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
    var controlTapped: (() -> Void)?
    
    private let myTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 6
        return label
    }()
    
    private let showMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show more", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myTextLabel)
        contentView.addSubview(showMoreButton)
        setupTapGesture()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myTextLabel.text = nil
    }
    
    private func setupTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.onTap(_:)))
        self.showMoreButton.addGestureRecognizer(tap)
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        if isLabelAtMaxHeight {
            showMoreButton.setTitle("Show more", for: .normal)
            myTextLabel.numberOfLines = 6
        }
        else {
            showMoreButton.setTitle("Show less", for: .normal)
            myTextLabel.numberOfLines = 0
        }
        isLabelAtMaxHeight.toggle()
        controlTapped?()
    }
    
    private func setupCell() {
        let labelTopConstraint = myTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        
        NSLayoutConstraint.activate([
            labelTopConstraint,
            myTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            showMoreButton.topAnchor.constraint(equalTo: myTextLabel.bottomAnchor, constant: 4),
            showMoreButton.leadingAnchor.constraint(equalTo: myTextLabel.leadingAnchor),
            showMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        labelTopConstraint.priority = .init(999)
    }
    
    public func configure(with text: String?) {
        myTextLabel.text = text
    }
}
