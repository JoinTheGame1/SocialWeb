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
    
    func getFriends(whom userId: String, completion: @escaping (Result<[Friend], APIerror>) -> Void) {
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
                completion(.failure(.serverError))
                print(error)
            }
            
            guard let data = response.data else {
                completion(.failure(.notData))
                return
            }
            
            do {
                let responceFriends = try JSONDecoder().decode(FriendsResponse.self, from: data)
                let friends = responceFriends.response.items
                completion(.success(friends))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
}
