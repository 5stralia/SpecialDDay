//
//  AddingItemEntity.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import Foundation

class AddingItemEntity: ObservableObject {
    @Published var title: String
    @Published var timestamp: Date
    @Published var note: String
    let createdTimestamp: Date

    init(
        title: String = "",
        timestamp: Date = Date(),
        note: String = "",
        createdTimestamp: Date = Date()
    ) {
        self.title = title
        self.timestamp = timestamp
        self.note = note
        self.createdTimestamp = createdTimestamp
    }
}

extension AddingItemEntity: Hashable {
    static func == (lhs: AddingItemEntity, rhs: AddingItemEntity) -> Bool {
        lhs.title == rhs.title &&
        lhs.timestamp == rhs.timestamp &&
        lhs.note == rhs.note &&
        lhs.createdTimestamp == rhs.createdTimestamp
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(timestamp)
        hasher.combine(note)
        hasher.combine(createdTimestamp)
    }
}
