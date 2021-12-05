//
//  CommentButton.swift
//  SocialWeb
//
//  Created by Никитка on 02.11.2021.
//

import UIKit

class CommentButton: UIButton {
    var counter = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsDisplay()
    }
    
    public func configure(counter: Int) {
        self.counter = counter
        self.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        self.imageView?.tintColor = UIColor.systemTeal
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
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.systemTeal, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
    }
}
