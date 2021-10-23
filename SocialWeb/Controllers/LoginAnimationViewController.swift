//
//  LoginAnimationViewController.swift
//  SocialWeb
//
//  Created by Никитка on 31.07.2021.
//

import UIKit

class LoginAnimationViewController: UIViewController {
    @IBOutlet weak var dotsStackView: UIStackView!
    private let dot1 = UIView()
    private let dot2 = UIView()
    private let dot3 = UIView()
    private lazy var dots = [dot1, dot2, dot3]
    private var countAnimation = 0
    
    private let friendsService = FriendsService()
    private let photosService = PhotosService()
    private let groupsService = GroupsService()
    private let myId = MySession.shared.userId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsService.getFriends(whom: self.myId)
        photosService.getPhotos(whom: self.myId)
        groupsService.getGroups(whom: self.myId)
        configureStack()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
       
    }
    
    func configureStack() {
        dotsStackView.axis = .horizontal
        dotsStackView.spacing = 145 / 2
        dotsStackView.alignment = .center
        dotsStackView.distribution = .fill
        
        dots.forEach {
            $0.layer.backgroundColor = UIColor(named: "loginBackground1")?.cgColor
            $0.layer.cornerRadius = 35 / 2
            $0.alpha = 0
            $0.layer.masksToBounds = true
            dotsStackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: 35).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
    }
    
    func animate() {
        
        UIView.animateKeyframes(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 1/6) {
                    self.dot1.alpha = 1
                    self.dot1.transform = CGAffineTransform(scaleX: 2, y: 2)
                }
                UIView.addKeyframe(withRelativeStartTime: 1/6,
                                   relativeDuration: 1/6) {
                    self.dot1.alpha = 0.2
                    self.dot1.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                UIView.addKeyframe(withRelativeStartTime: 2/6,
                                   relativeDuration: 1/6) {
                    self.dot2.alpha = 1
                    self.dot2.transform = CGAffineTransform(scaleX: 2, y: 2)
                }
                UIView.addKeyframe(withRelativeStartTime: 3/6,
                                   relativeDuration: 1/6) {
                    self.dot2.alpha = 0.2
                    self.dot2.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                UIView.addKeyframe(withRelativeStartTime: 4/6,
                                   relativeDuration: 1/6) {
                    self.dot3.alpha = 1
                    self.dot3.transform = CGAffineTransform(scaleX: 2, y: 2)
                }
                UIView.addKeyframe(withRelativeStartTime: 5/6,
                                   relativeDuration: 1/6) {
                    self.dot3.alpha = 0.2
                    self.dot3.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                                    
            },completion:  { [weak self] _ in
                guard let self = self else { return }
                self.countAnimation += 1
                if self.countAnimation > 1 {
                    self.performSegue(withIdentifier: "toTabBarController", sender: self)
                } else {
                    self.animate()
                }
            })
    }
}
