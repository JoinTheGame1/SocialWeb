//
//  FriendsService.swift
//  SocialWeb
//
//  Created by Никитка on 26.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

final class FriendsService {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.131"
    
    func getFriends(whom userId: String) {
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "hints",
            "count": 1000,
            "fields": "photo_100",
            "access_token": token,
            "v": version
            ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let error = response.error {
                print(error)
            }
            
            guard let data = response.data else { return }
            var friends = [Friend]()
            DispatchQueue.main.async {
                do {
                    let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: data)
                    friends = friendsResponse.response.items
                } catch {
                    print(error)
                }
                RealmService.shared.cache(friends)
            }
        }
    }
}
