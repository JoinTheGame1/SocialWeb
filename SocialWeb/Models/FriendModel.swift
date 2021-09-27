//
//  FriendModel.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import UIKit

struct Friend {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: String
    let photos: [String]
}

struct FriendStorage {
    static let shared = FriendStorage()
    
    var friends: [Friend]
    private init(){
        friends = [
            Friend(id: 0, firstName: "Никола", lastName: "Тесла", avatar: "Tesla", photos: ["defaultIcon", "Tesla"]),
            Friend(id: 1, firstName: "Альберт", lastName: "Эйнштейн", avatar: "Einstein", photos: ["defaultIcon", "Einstein"]),
            Friend(id: 2, firstName: "Уильям", lastName: "Гамильтон", avatar: "Hamilton", photos: ["defaultIcon", "Hamilton"]),
            Friend(id: 3, firstName: "Жуль Анри", lastName: "Пуанкаре", avatar: "Puankare", photos: ["defaultIcon", "Puankare"]),
            Friend(id: 4, firstName: "Дмитрий", lastName: "Менделеев", avatar: "Mendeleev", photos: ["defaultIcon", "Mendeleev"]),
            Friend(id: 5, firstName: "Майкл", lastName: "Фарадей", avatar: "Faraday", photos: ["defaultIcon", "Faraday"]),
            Friend(id: 6, firstName: "Жуль", lastName: "Верн", avatar: "Verne", photos: ["defaultIcon", "Verne", "Popov", "Faraday", "Puankare"]),
            Friend(id: 7, firstName: "Николай", lastName: "Пирогов", avatar: "Pirogov", photos: ["defaultIcon", "Pirogov"]),
            Friend(id: 8, firstName: "Александр", lastName: "Попов", avatar: "Popov", photos: ["defaultIcon", "Popov"]),
            Friend(id: 9, firstName: "Чарлз", lastName: "Дарвин", avatar: "Darwin", photos: ["defaultIcon", "Darwin"]),
            Friend(id: 10, firstName: "Владимир", lastName: "Вернадский", avatar: "Vernadskiy", photos: ["defaultIcon", "Vernadskiy"]),
            Friend(id: 11, firstName: "Владимир", lastName: "Обручев", avatar: "Obruchev", photos: ["defaultIcon", "Obruchev"]),
            Friend(id: 12, firstName: "Мария", lastName: "Склодовская-Кюри", avatar: "Sklodowska-Curie", photos: ["defaultIcon", "Sklodowska-Curie"])
        ]
    }
}
