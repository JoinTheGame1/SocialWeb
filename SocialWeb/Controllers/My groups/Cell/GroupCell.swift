//
//  GroupCell.swift
//  SocialWeb
//
//  Created by Никитка on 25.07.2021.
//

import UIKit

class GroupCell: UITableViewCell {
    static let identifier = "GroupCell"
    var buttonUnfollowGroup: ((UITableViewCell) -> Void)?
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBAction func deleteGroup(_ sender: Any) {
        buttonUnfollowGroup?(self)
    }
    @IBAction func tap(sender: UITapGestureRecognizer) {
        GroupCell.animate(withDuration: 0.5,
                                         delay: 0,
                                         usingSpringWithDamping: 0.5,
                                         initialSpringVelocity: 0.1,
                                         options: [],
                                         animations: {
                                            self.avatarImageView.bounds = self.avatarImageView.bounds.insetBy(dx: -10, dy: -10)
                                         })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(GroupCell.tap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(_ group: Group) {
        let url = URL(string: group.photo)
        avatarImageView.kf.setImage(with: url)
        nameLabel.text = group.name
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
    }
    
}
