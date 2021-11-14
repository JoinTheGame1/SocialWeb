//
//  RealmService.swift
//  SocialWeb
//
//  Created by Никитка on 14.10.2021.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    var realm = try? Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
    
    private init() {}
    
    func cache<T: Object>(_ data: [T], param: String, filterText: String) {
        do {
            print("-----RealmFile-----")
            print(realm?.configuration.fileURL!)
            print("-------------------")
            
            let oldData = (realm?.objects(T.self).filter("\(param) == \(filterText)"))!
            realm?.beginWrite()
            realm?.delete(oldData)
            realm?.add(data)
            try realm?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func cache<T: Object>(_ data: [T]) {
        do {
            print("-----RealmFile-----")
            print(realm?.configuration.fileURL!)
            print("-------------------")
            
            let oldData = (realm?.objects(T.self))!
            realm?.beginWrite()
            realm?.delete(oldData)
            realm?.add(data)
            try realm?.commitWrite()
        } catch {
            print(error)
        }
    }
}
