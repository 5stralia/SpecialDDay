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
    private let item: NSManagedObject

    init(addingItem: AddingItemEntity, item: NSManagedObject) {
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
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
}

struct EdittingItemView_Previews: PreviewProvider {
    static var previews: some View {
        EdittingItemView(
            addingItem: AddingItemEntity(),
            item: NSManagedObject(context: PersistenceController.preview.container.viewContext)
        )
    }
}
