//
//  SettingsModels.swift
//  Dashboard
//
//  Created by User on 10.06.2024.
//

import Foundation

struct SettingsItem: Codable {
    let id: Int
    var countVals: Int
    var priority: Int
    let user: Int
    let group: Int
    var typeCount: Int
    var drawingType: Int
    let name: String
    var active: Bool

    // Задаем соответствие имен ключей JSON и имен свойств структуры
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countVals = "CountVals"
        case priority = "Priority"
        case user = "User"
        case group = "Group"
        case typeCount = "TypeCount"
        case drawingType = "DrawingType"
        case name = "Name"
        case active = "Active"
    }
}


struct DrawingItem: Codable {
    let id: Int
    let name: String
    let comment: String

    // Задаем соответствие имен ключей JSON и имен свойств структуры
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case comment = "Comment"
    }
}

struct CountItem: Codable {
    let id: Int
    let name: String
    
    // Задаем соответствие имен ключей JSON и имен свойств структуры
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}
