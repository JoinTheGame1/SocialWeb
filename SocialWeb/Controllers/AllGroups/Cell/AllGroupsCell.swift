//
//  AllGroupsCell.swift
//  SocialWeb
//
//  Created by Никитка on 25.07.2021.
//

import UIKit
import Kingfisher

class AllGroupsCell: UITableViewCell {
    static let identifier = "AllGroupsCell"
    var buttonFollowGroup: ((UITableViewCell) -> Void)?
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBAction func followGroup(_ sender: Any) {
        buttonFollowGroup?(self)
    }
    @IBAction func tap(sender: UITapGestureRecognizer) {
        AllGroupsCell.animate(withDuration: 0.5,
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(AllGroupsCell.tap))
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
