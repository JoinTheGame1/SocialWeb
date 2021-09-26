//
//  ProfileView.swift
//  SocialWeb
//
//  Created by Никитка on 19.07.2021.
//

import UIKit

@IBDesignable class ProfileView: UIView {
    
    @IBOutlet weak var AvatarBackground: UIView!
    @IBOutlet weak var AvatarImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let ABlayer = AvatarBackground.layer
        
        AvatarImage.layer.cornerRadius = 120
        ABlayer.cornerRadius = 120
        ABlayer.backgroundColor = UIColor.white.cgColor
        ABlayer.borderWidth = 2
        ABlayer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

@IBDesignable class avatarBackground: UIView{
    
}

extension UIView {
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue}
        get { return layer.shadowOffset }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue}
        get { return layer.shadowOpacity }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set { layer.shadowRadius = newValue}
        get { return layer.shadowRadius }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set { layer.shadowColor = newValue?.cgColor}
        get { let color = UIColor(cgColor: layer.shadowColor!)
            return color
        }
    }
}
