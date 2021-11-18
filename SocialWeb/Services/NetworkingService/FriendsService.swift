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
        let request = AF.request(url, method: .get, parameters: parameters)
        
        let operationQueue = OperationQueue()
        let getData = GetDataOperation(request: request)
        let parseData = ParseDataOperation<Friend>()
        let saveData = SaveDataOperation<Friend>()
        
        parseData.addDependency(getData)
        saveData.addDependency(parseData)
        
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
        OperationQueue.main.addOperation(saveData)
    }
}
