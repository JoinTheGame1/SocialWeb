//
//  PhotosAPI.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import Foundation
import Alamofire

final class PhotosAPI {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.131"
    
    func getPhotos() {
        let method = "/photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": userId,
            "no_service_albums": 1,
            "extended": 1,
            "count": 200,
            "access_token": token,
            "v": version
            ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
}
