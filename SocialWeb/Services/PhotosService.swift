//
//  PhotosService.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import Foundation
import Alamofire

final class PhotosService {
    let realmService = RealmService()
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.131"
    
    func getPhotos(whom userId: String, completion: @escaping () -> Void) {
        let method = "/photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": userId,
            "extended": 1,
            "count": 100,
            "access_token": token,
            "v": version
            ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let error = response.error {
                print(error)
            }
            
            guard let data = response.data else { return }
            var photos = [Photo]()
            
            do {
                let photosResponce = try JSONDecoder().decode(PhotosResponse.self, from: data)
                photos = photosResponce.response.items
            } catch {
                print(error)
            }
            
            self.realmService.cache(photos, param: "ownerId", filterText: userId, completion: completion)
        }
    }
}
