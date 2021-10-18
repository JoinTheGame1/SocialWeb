//
//  FriendCollectionViewController.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import UIKit
import RealmSwift

class FriendCollectionViewController: UIViewController{
    private var collectionView: UICollectionView?
    var friend: Friend!
    var friendPhotos = [Photo]()
    let photosService = PhotosService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let itemWidth = view.frame.size.width / 2 - 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        photosService.getPhotos(whom: String(friend.id)) { [weak self] in
            guard let self = self else { return }
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL!)
                self.friendPhotos = Array(realm.objects(Photo.self).filter("ownerId == %@", String(self.friend.id)))
                self.collectionView?.reloadData()
            } catch {
                print(error)
            }
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
            view?.allPhotos = friendPhotos
            view?.index = indexPath.item
        }
    }
    
}

extension FriendCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friendPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.identifier, for: indexPath) as! FriendCollectionViewCell
        cell.configure(friendPhotos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAllPhotos", sender: indexPath)
    }
}
