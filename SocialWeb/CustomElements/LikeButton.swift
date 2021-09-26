//
//  LikeButton.swift
//  SocialWeb
//
//  Created by Никитка on 22.07.2021.
//

import UIKit

class LikeButton: UIButton {
    
    var counter = Int.random(in: 0...99)
    var liked = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsDisplay()
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        self.setTitle("\(liked ? "♥" : "♡") \(counter)", for: .normal)
        self.backgroundColor = liked ? UIColor.systemPink : UIColor.clear
        self.setTitleColor(liked ? UIColor.white : UIColor.systemTeal, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 4.0
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    @objc func onTap(_ sender: UIButton) {
        self.liked.toggle()

        UIButton.transition(with: self,
                            duration: 0.5,
                            options: [.transitionFlipFromLeft, .allowUserInteraction],
                            animations: {
                                self.counter += self.liked ? 1 : -1
                            })
    }
}

