//
//  ProfileViewController.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    private var collectionView: UICollectionView?
    let myId = MySession.shared.userId
    let photosAPI = PhotosAPI()
    var myPhotos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosAPI.getPhotos(whom: self.myId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(.decodeError):
                print("Decode error...")
            case .failure(.notData):
                print("Have no data...")
            case .failure(.serverError):
                print("Server error...")
            case .success(let photos):
                self.myPhotos = photos
                self.collectionView?.reloadData()
            }
        }
        
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
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.myPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        cell.configure(self.myPhotos[indexPath.row])
        return cell
    }
}
