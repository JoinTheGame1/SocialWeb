//
//  ParseDataOperation.swift
//  SocialWeb
//
//  Created by Никитка on 18.11.2021.
//

import Foundation
import RealmSwift

class ParseDataOperation<T: Codable & Object>: Operation {
    private(set) var outputData: [T]?
    private let decoder = JSONDecoder()

    override func main() {
        guard
            let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data
        else {
            print("Data didn't loaded...")
            return
        }

        do {
            let responce = try decoder.decode(Response<T>.self, from: data).response.items
            outputData = responce
        } catch {
            print("Failed to decode the data...")
        }
    }
}
