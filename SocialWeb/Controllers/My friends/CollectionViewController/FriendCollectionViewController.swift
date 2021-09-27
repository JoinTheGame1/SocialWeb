//
//  FriendCollectionViewController.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import UIKit

class FriendCollectionViewController: UIViewController{
    private var collectionView: UICollectionView?
    var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let itemWidth = view.frame.size.width / 2 - 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FriendCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        navigationItem.title = friend!.firstName + " " + friend!.lastName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllPhotos" {
            let view = segue.destination as? FriendAllPhotosViewController
            let indexPath = sender as! IndexPath
            view?.allPhotos = friend.photos
            view?.index = indexPath.item
        }
    }
    
}

extension FriendCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friend.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.identifier, for: indexPath) as! FriendCollectionViewCell
        cell.configure(friend, indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAllPhotos", sender: indexPath)
    }
}
