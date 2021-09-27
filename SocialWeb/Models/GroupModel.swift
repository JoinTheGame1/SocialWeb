//
//  GroupModel.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import UIKit

struct Group: Hashable {
    let id: Int
    let name: String
    let avatarGroupName: String
    
    init(id: Int, name: String, avatarGroupName: String) {
        self.id = id
        self.name = name
        self.avatarGroupName = avatarGroupName
    }
}

struct GroupStorage {
    static var allGroups = [
        Group(id: 0, name: "Научные мемы", avatarGroupName: "Science memes"),
        Group(id: 1, name: "Мемы про животных", avatarGroupName: "Pet memes"),
        Group(id: 2, name: "Цитаты великих ученых", avatarGroupName: "Цитаты"),
        Group(id: 3, name: "Wild Math", avatarGroupName: "Wild Math"),
        Group(id: 4, name: "Квантовая механика", avatarGroupName: "Квантовая механика"),
        Group(id: 5, name: "Интересные факты", avatarGroupName: "Интересные факты"),
        Group(id: 6, name: "World of History", avatarGroupName: "World of History"),
        Group(id: 7, name: "Пикабу", avatarGroupName: "Пикабу")
    ]
    
    static var myGroups = allGroups.filter {$0.id == 1 || $0.id == 2 || $0.id == 3 || $0.id == 4}
}

