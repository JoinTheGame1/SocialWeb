//
//  SaveDataOperation.swift
//  SocialWeb
//
//  Created by Никитка on 18.11.2021.
//

import Foundation
import RealmSwift

class SaveDataOperation<T: Codable & Object>: Operation {
    private let param: String?
    private let filterText: String?
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
              let outputData = parseDataOperation.outputData
        else {
            print("Data didn't parced...")
            return
        }
        if let param = param,
           let filterText = filterText {
            RealmService.shared.cache(outputData, param: param, filterText: filterText)
        } else {
            RealmService.shared.cache(outputData)
        }
    }
    
    override init() {
        self.param = nil
        self.filterText = nil
    }
    
    init(paramToSave: String, filterTextToSave: String) {
        self.param = paramToSave
        self.filterText = filterTextToSave
    }
    
}
