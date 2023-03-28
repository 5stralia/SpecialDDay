//
//  EdittingItemView.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import CoreData
import SwiftUI

struct EdittingItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isShowAlert: Bool = false

    @ObservedObject private var addingItem: AddingItemEntity
    private let item: Item

    init(addingItem: AddingItemEntity, item: Item) {
        self.addingItem = addingItem
        self.item = item
    }

    var body: some View {
        DetailItemView(addingItem: addingItem, isShowAlert: $isShowAlert, doneAction: doneAction)
    }

    private func doneAction() {
        item.setValue(addingItem.title, forKey: "title")
        item.setValue(addingItem.timestamp, forKey: "timestamp")
        item.setValue(addingItem.note, forKey: "note")

        do {
            try CoreDataManager.shared.update(
                item,
                to: ItemEntity(
                    id: nil,
                    title: addingItem.title,
                    timestamp: addingItem.timestamp,
                    note: addingItem.note,
                    createdDate: addingItem.createdTimestamp,
                    lastEdited: Date()
                )
            )
        } catch let error {
            print(error)
        }
    }
}

struct EdittingItemView_Previews: PreviewProvider {
    static var previews: some View {
        EdittingItemView(
            addingItem: AddingItemEntity(),
            item: Item.init(context: PersistenceController.preview.container.viewContext)
        )
    }
}
