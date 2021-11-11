//
//  FirebaseUser.swift
//  SocialWeb
//
//  Created by Никитка on 26.10.2021.
//

import Foundation
import FirebaseDatabase

class FirebaseUser {
    let id: Int
    var groups: [FirebaseGroup] = []
    let ref: DatabaseReference?
    var toFire: [String: Any] {
        return groups.map{ $0.toAnyObject() }.reduce([:]) { $0.merging($1) { (current, _) in current } }
    }

    init(id: Int){
        self.id = id
        self.ref = nil
        self.groups = []
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let groups = value["groups"] as? [FirebaseGroup] else {
                return nil
        }
        self.ref = snapshot.ref
        self.id = id
        self.groups = groups
    }

    func toAnyObject() -> [String: Any] {
        return [
            "id": id,
            "groups" : toFire
        ]
    }
}
