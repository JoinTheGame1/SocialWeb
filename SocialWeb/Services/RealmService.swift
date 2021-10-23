//
//  RealmService.swift
//  SocialWeb
//
//  Created by Никитка on 14.10.2021.
//

import Foundation
import RealmSwift

class RealmService {
    func cache<T: Object>(_ data: [T], param: String, filterText: String) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            
            print("-----RealmFile-----")
            print(realm.configuration.fileURL!)
            print("-------------------")
            
            let oldData = realm.objects(T.self).filter("\(param) == \(filterText)")
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func cache<T: Object>(_ data: [T]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            
            print("-----RealmFile-----")
            print(realm.configuration.fileURL!)
            print("-------------------")
            
            let oldData = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
