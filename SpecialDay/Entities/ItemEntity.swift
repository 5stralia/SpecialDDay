//
//  ItemEntity.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import Foundation

public struct ItemEntity: Codable {
    let id: String?
    let title: String?
    let timestamp: Date?
    let note: String?
    let createdDate: Date?
    let lastEdited: Date?
}
