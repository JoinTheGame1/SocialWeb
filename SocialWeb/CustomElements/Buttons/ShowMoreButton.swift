//
//  ShowMoreButton.swift
//  SocialWeb
//
//  Created by Никитка on 25.11.2021.
//

import UIKit

class ShowMoreButton: UIButton {
    var isMore = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setNeedsDisplay()
    }
    
    public func configure() {
        self.setTitle(isMore ? "Show less" : "Show more", for: .normal)
        self.setTitleColor(UIColor.link, for: .normal)
    }
    
    
}
