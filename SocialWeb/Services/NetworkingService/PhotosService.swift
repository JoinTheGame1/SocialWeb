//
//  PhotosService.swift
//  SocialWeb
//
//  Created by Никитка on 27.09.2021.
//

import Foundation
import Alamofire

final class PhotosService {
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.131"
    
    func getPhotos(whom userId: String) {
        let method = "/photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": userId,
            "extended": 1,
            "count": 100,
            "access_token": token,
            "v": version
            ]
        
        let url = baseUrl + method
        let request = AF.request(url, method: .get, parameters: parameters)
        
        let operationQueue = OperationQueue()
        let getData = GetDataOperation(request: request)
        let parseData = ParseDataOperation<Photo>()
        let saveData = SaveDataOperation<Photo>(paramToSave: "ownerId", filterTextToSave: userId)
        
        parseData.addDependency(getData)
        saveData.addDependency(parseData)
        
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
        OperationQueue.main.addOperation(saveData)
    }
}
