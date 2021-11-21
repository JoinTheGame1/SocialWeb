//
//  GroupsService.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import Foundation
import Alamofire
import RealmSwift

final class GroupsService {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.131"
    
    func getGroups(whom userId: String) {
        let method = "/groups.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "count": 1000,
            "access_token": token,
            "v": version
            ]
        
        let url = baseUrl + method
        let request = AF.request(url, method: .get, parameters: parameters)
        
        let operationQueue = OperationQueue()
        let getData = GetDataOperation(request: request)
        let parseData = ParseDataOperation<Group>()
        let saveData = SaveDataOperation<Group>()
        
        parseData.addDependency(getData)
        saveData.addDependency(parseData)
        
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
        OperationQueue.main.addOperation(saveData)
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
        let request = AF.request(url, method: .get, parameters: parameters)
        
        let operationQueue = OperationQueue()
        let getData = GetDataOperation(request: request)
        let parseData = ParseDataOperation<Group>()
        parseData.completionBlock = {
            guard let groups = parseData.outputData else { return }
            completion(.success(groups))
        }
        
        parseData.addDependency(getData)
        
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
    }
}
