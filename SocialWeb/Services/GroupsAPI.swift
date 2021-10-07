//
//  GroupsAPI.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import Foundation
import Alamofire

final class GroupsAPI {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.131"
    
    func getGroups(whom userId: String, completion: @escaping (Result<[Group], APIerror>) -> Void) {
        let method = "/groups.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "count": 1000,
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
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                let groups = groupsResponse.response.items
                completion(.success(groups))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
    
    func getSearchGroups(with text: String, completion: @escaping (Result<[Group], APIerror>) -> Void) {
        let method = "/groups.search"
        
        let parameters: Parameters = [
            "count": 1000,
            "access_token": token,
            "v": version,
            "q": text
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
                let groupsResponce = try JSONDecoder().decode(GroupsResponse.self, from: data)
                let groups = groupsResponce.response.items
                completion(.success(groups))
            } catch {
                completion(.failure(.decodeError))
            }
        }
    }
}
