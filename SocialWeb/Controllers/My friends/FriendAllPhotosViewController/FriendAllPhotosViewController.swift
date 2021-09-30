//
//  FriendAllPhotosViewController.swift
//  SocialWeb
//
//  Created by Никитка on 03.08.2021.
//

import UIKit

class FriendAllPhotosViewController: UIViewController {
    @IBOutlet var friendAllPhotosView: FriendAllPhotosView!
    var allPhotos = [String]()
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendAllPhotosView.configure(allPhotos: allPhotos, currentIndex: index)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        friendAllPhotosView.previousPhoto.removeFromSuperview()
    }
}

