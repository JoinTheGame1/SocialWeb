//
//  ProfileViewController.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import UIKit
import RealmSwift
import FirebaseAuth

class ProfileViewController: UIViewController {
    private var collectionView: UICollectionView?
    private let myId = MySession.shared.userId
    private let photosService = PhotosService()
    private let realm = RealmService.shared.realm
    private var realmPhotos: Results<Photo>?
    private var token: NotificationToken?
    
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
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        pairTableAndRealm()
    }
    
    private func pairTableAndRealm() {
        guard let realm = self.realm else { return }
        self.realmPhotos = realm.objects(Photo.self).filter("ownerId == %D", Int(self.myId) ?? 0)
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
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(signInViewController, animated: true, completion: nil)
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.realmPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        guard let photo = realmPhotos?[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.configure(photo)
        return cell
    }
}
