//
//  FriendsAPI.swift
//  SocialWeb
//
//  Created by Никитка on 26.09.2021.
//

import Foundation
import Alamofire

final class FriendsAPI {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.131"
    
    func getFriends() {
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "count": 1000,
            "fields": "photo_100, photo_50",
            "access_token": token,
            "v": version
            ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response)
        }
    }
}
