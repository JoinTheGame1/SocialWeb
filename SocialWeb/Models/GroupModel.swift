//
//  GroupModel.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import Foundation
import RealmSwift

// MARK: - Group
class Group: Object, Codable, ProfileRepresentable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_200"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}



