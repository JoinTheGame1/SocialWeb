//
//  RepostButton.swift
//  SocialWeb
//
//  Created by Никитка on 02.11.2021.
//

import UIKit

class RepostButton: UIButton {
    var counter = 0
    var reposted = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsDisplay()
    }
    
    public func configure(counter: Int, reposted: Bool) {
        self.counter = counter
        self.reposted = reposted
        self.setImage(reposted ? UIImage(systemName: "arrowshape.turn.up.left.fill") : UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
        self.imageView?.tintColor = reposted ? UIColor.white : UIColor.systemTeal
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
        self.backgroundColor = reposted ? UIColor.systemBlue : UIColor.clear
        self.setTitleColor(reposted ? UIColor.white : UIColor.systemTeal, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 12.0
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    @objc func onTap(_ sender: UIButton) {
        self.reposted.toggle()

        UIButton.transition(with: self,
                            duration: 0.5,
                            options: [.transitionFlipFromLeft, .allowUserInteraction],
                            animations: {
                                self.counter += self.reposted ? 1 : -1
                                self.configure(counter: self.counter, reposted: self.reposted)
                            })
    }
}
