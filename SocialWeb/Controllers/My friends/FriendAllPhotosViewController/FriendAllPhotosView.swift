//
//  FriendAllPhotosView.swift
//  SocialWeb
//
//  Created by Никитка on 05.08.2021.
//

import UIKit
import Kingfisher

class FriendAllPhotosView: UIView {
    var previousPhoto: UIImageView = {
        let previousPhoto = UIImageView()
        previousPhoto.translatesAutoresizingMaskIntoConstraints = false
        return previousPhoto
    }()
    
    private var currentPhoto: UIImageView = {
        let currentPhoto = UIImageView()
        currentPhoto.translatesAutoresizingMaskIntoConstraints = false
        return currentPhoto
    }()
    
    private var nextPhoto: UIImageView = {
        let nextPhoto = UIImageView()
        nextPhoto.translatesAutoresizingMaskIntoConstraints = false
        return nextPhoto
    }()
    
    var allPhotos: [Photo] = []
    var currentIndex: Int = 0
    private var beginCenterXpreviousPhoto: CGFloat = 0
    private var beginCenterXcurrentPhoto: CGFloat = 0
    private var beginCenterXnextPhoto: CGFloat = 0
    
    private var panGesture: UIPanGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        beginCenterXpreviousPhoto = previousPhoto.frame.midX
        beginCenterXcurrentPhoto = currentPhoto.center.x
        beginCenterXnextPhoto = nextPhoto.center.x
    }
    
    func configure(allPhotos: [Photo], currentIndex: Int) {
        self.allPhotos = allPhotos
        self.currentIndex = currentIndex
        setupPhotos()
    }
    
    private func setupViews() {
        addSubview(previousPhoto)
        addSubview(currentPhoto)
        addSubview(nextPhoto)
        
        NSLayoutConstraint.activate([
            currentPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            currentPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            currentPhoto.heightAnchor.constraint(equalTo: currentPhoto.widthAnchor),
            currentPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            previousPhoto.widthAnchor.constraint(equalTo: currentPhoto.widthAnchor),
            previousPhoto.heightAnchor.constraint(equalTo: currentPhoto.widthAnchor),
            previousPhoto.trailingAnchor.constraint(equalTo: currentPhoto.leadingAnchor, constant: -16),
            previousPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nextPhoto.widthAnchor.constraint(equalTo: currentPhoto.widthAnchor),
            nextPhoto.heightAnchor.constraint(equalTo: currentPhoto.widthAnchor),
            nextPhoto.leadingAnchor.constraint(equalTo: currentPhoto.trailingAnchor, constant: 16),
            nextPhoto.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        previousPhoto.layer.cornerRadius = 16
        previousPhoto.alpha = 0.8
        previousPhoto.layer.masksToBounds = true
        currentPhoto.layer.cornerRadius = 16
        currentPhoto.alpha = 1
        currentPhoto.layer.masksToBounds = true
        currentPhoto.isUserInteractionEnabled = true
        nextPhoto.layer.cornerRadius = 16
        nextPhoto.alpha = 0.8
        nextPhoto.layer.masksToBounds = true
    }
    
    private func setupGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        guard let gesture = panGesture else { return }
        currentPhoto.addGestureRecognizer(gesture)
    }
    
    private func setupPhotos() {
        guard
            !allPhotos.isEmpty
        else {
            return
        }
        
        var url = URL(string: allPhotos[previousIndex()].sizes.last!.url)
        previousPhoto.kf.setImage(with: url)
        url = URL(string: allPhotos[currentIndex].sizes.last!.url)
        currentPhoto.kf.setImage(with: url)
        url = URL(string: allPhotos[nextIndex()].sizes.last!.url)
        nextPhoto.kf.setImage(with: url)
    }
    
    private func previousIndex() -> Int {
        if currentIndex == 0 {
            return allPhotos.count - 1
        }
        return currentIndex - 1
    }
    
    private func nextIndex() -> Int {
        if currentIndex == allPhotos.count - 1 {
            return 0
        }
        return currentIndex + 1
    }
    
    private func getIdentity() {
        let transform = CGAffineTransform(scaleX: 1, y: 1)
        UIImageView.animate(withDuration: 0.3,
                            animations: {
                                self.previousPhoto.transform = transform
                                self.currentPhoto.transform = transform
                                self.nextPhoto.transform = transform
                            })
    }
    
    private func leftSwipe() {
        self.currentPhoto.isUserInteractionEnabled = false
        UIImageView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.currentPhoto.center.x = self.beginCenterXpreviousPhoto
                self.nextPhoto.center.x = self.beginCenterXcurrentPhoto
                self.currentIndex = self.nextIndex()
            },
            completion: { _ in
                self.currentPhoto.isUserInteractionEnabled = true
                self.previousPhoto.center.x = self.beginCenterXpreviousPhoto
                self.currentPhoto.center.x = self.beginCenterXcurrentPhoto
                self.nextPhoto.center.x = self.beginCenterXnextPhoto
                self.getIdentity()
                self.setupPhotos()
            })
    }
    
    private func rightSwipe() {
        self.currentPhoto.isUserInteractionEnabled = false
        UIImageView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.previousPhoto.center.x = self.beginCenterXcurrentPhoto
                self.currentPhoto.center.x = self.beginCenterXnextPhoto
                self.currentIndex = self.previousIndex()
            },
            completion: { _ in
                self.currentPhoto.isUserInteractionEnabled = true
                self.previousPhoto.center.x = self.beginCenterXpreviousPhoto
                self.currentPhoto.center.x = self.beginCenterXcurrentPhoto
                self.nextPhoto.center.x = self.beginCenterXnextPhoto
                self.getIdentity()
                self.setupPhotos()
            })
    }
    
    private func revert() {
        self.currentPhoto.isUserInteractionEnabled = false
        UIImageView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.25,
            initialSpringVelocity: 0.75,
            options: .curveEaseInOut,
            animations: {
                self.previousPhoto.center.x = self.beginCenterXpreviousPhoto
                self.currentPhoto.center.x = self.beginCenterXcurrentPhoto
                self.nextPhoto.center.x = self.beginCenterXnextPhoto
            },
            completion: { _ in
                self.currentPhoto.isUserInteractionEnabled = true
                self.previousPhoto.center.x = self.beginCenterXpreviousPhoto
                self.currentPhoto.center.x = self.beginCenterXcurrentPhoto
                self.nextPhoto.center.x = self.beginCenterXnextPhoto
                self.getIdentity()
                self.setupPhotos()
            })
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        UIImageView.animate(withDuration: 0.3,
                            animations: {
                                let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                self.previousPhoto.transform = transform
                                self.currentPhoto.transform = transform
                                self.nextPhoto.transform = transform
                            })
        
        let translation = gesture.translation(in: currentPhoto).x
        
        previousPhoto.center.x = previousPhoto.center.x + translation
        currentPhoto.center.x = currentPhoto.center.x + translation
        nextPhoto.center.x = nextPhoto.center.x + translation
        
        gesture.setTranslation(.zero, in: self.currentPhoto)
        
        if gesture.state ==  .ended {
            let offset = beginCenterXcurrentPhoto - currentPhoto.center.x
            if offset > 50 {
                leftSwipe()
            } else if offset < -50 {
                rightSwipe()
            } else {
                revert()
            }
        }
    }
}

