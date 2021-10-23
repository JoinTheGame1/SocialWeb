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
    private var realmPhotos: Results<Photo>?
    private var token: NotificationToken?
    private let photosService = PhotosService()
    
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
        
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FriendCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        navigationItem.title = friend!.firstName + " " + friend!.lastName
        photosService.getPhotos(whom: String(friend.id))
        pairTableAndRealm()
    }
    
    private func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        self.realmPhotos = realm.objects(Photo.self).filter("ownerId == %D", Int(self.friend.id))
        self.token = realmPhotos?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self,
                  let collectionView = self.collectionView
            else { return }
            
            switch changes {
            case .initial:
                collectionView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllPhotos" {
            let view = segue.destination as? FriendAllPhotosViewController
            let indexPath = sender as! IndexPath
            view?.allPhotos = Array(realmPhotos!)
            view?.index = indexPath.item
        }
    }
    
}

extension FriendCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        realmPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.identifier, for: indexPath) as! FriendCollectionViewCell
        guard let photo = realmPhotos?[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.configure(photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAllPhotos", sender: indexPath)
    }
}
