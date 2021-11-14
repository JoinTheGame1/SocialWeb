//
//  MyRelativeDateTimeFormatter.swift
//  SocialWeb
//
//  Created by Никитка on 12.11.2021.
//

import Foundation

class MyRelativeDateTimeFormatter {
    let formatter = RelativeDateTimeFormatter()
    
    func timeAgoDisplay(timeIntervalSince1970: Double) -> String {
        formatter.unitsStyle = .full
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
