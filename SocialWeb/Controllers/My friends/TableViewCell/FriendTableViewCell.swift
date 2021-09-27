//
//  FriendTableViewCell.swift
//  SocialWeb
//
//  Created by Никитка on 26.07.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    static let identifier = "FriendTableViewCell"
    
    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBAction func tap(sender: UITapGestureRecognizer) {
        FriendTableViewCell.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.1,
            options: [],
            animations: {
                self.friendImageView.bounds = self.friendImageView.bounds.insetBy(dx: -10, dy: -10)
            })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(FriendTableViewCell.tap))
        friendImageView.isUserInteractionEnabled = true
        friendImageView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ friend: Friend) {
        friendImageView.image = UIImage(named: friend.avatar)
        friendImageView.layer.cornerRadius = friendImageView.bounds.height / 2
        friendImageView.layer.borderWidth = 1
        friendImageView.layer.borderColor = UIColor.black.cgColor
        nameLabel.text = friend.firstName + " " + friend.lastName
    }
}
