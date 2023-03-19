//
//  ItemEntity.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import Foundation

struct ItemEntity {
    let title: String
    let days: Int
}

extension ItemEntity: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.title == rhs.title && lhs.days == rhs.days
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(days)
    }
}
