//
//  LikeButton.swift
//  SocialWeb
//
//  Created by Никитка on 22.07.2021.
//

import UIKit

class LikeButton: UIButton {
    
    var counter = 0
    var liked = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsDisplay()
    }
    
    public func configure(counter: Int, liked: Bool) {
        self.counter = counter
        self.liked = liked
        self.setImage(liked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        self.imageView?.tintColor = liked ? UIColor.white : UIColor.systemTeal
        let counterString: String?
        switch counter {
        case 0..<1000:
            counterString = String(counter)
        case 1000..<1_000_000:
            counterString = String(counter/1000) + "K"
        default:
            counterString = "-"
        }
        self.setTitle(counterString, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        self.backgroundColor = liked ? UIColor.systemPink : UIColor.clear
        self.setTitleColor(liked ? UIColor.white : UIColor.systemTeal, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
    @objc func onTap(_ sender: UIButton) {
        self.liked.toggle()

        UIButton.transition(with: self,
                            duration: 0.5,
                            options: [.transitionFlipFromLeft, .allowUserInteraction],
                            animations: {
                                self.counter += self.liked ? 1 : -1
                                self.configure(counter: self.counter, liked: self.liked)
                            })
    }
}

