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
    
    @IBOutlet private var avatarBackground: UIView!
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


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(_ group: Group) {
        do {
            let url = URL(string: group.photo)
            let data = try Data(contentsOf: url!)
            avatarImageView.image = UIImage(data: data)
            nameLabel.text = group.name
        } catch {
            print("error")
        }
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarBackground.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
}
