//
//  AddingItemView.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import CoreData
import SwiftUI

struct AddingItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isShowAlert: Bool = false

    @ObservedObject private var addingItem: AddingItemEntity

    init(addingItem: AddingItemEntity) {
        self.addingItem = addingItem
    }

    var body: some View {
        DetailItemView(addingItem: addingItem, isShowAlert: $isShowAlert, doneAction: doneAction)
    }

    private func doneAction() {
        withAnimation {
            do {
                try CoreDataManager.shared.add(
                    ItemEntity(
                        id: nil,
                        title: addingItem.title,
                        timestamp: addingItem.timestamp,
                        note: addingItem.note,
                        createdDate: addingItem.createdTimestamp,
                        lastEdited: Date()
                    )
                )
            } catch {
                isShowAlert = true
            }
        }
    }
}

struct AddingItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddingItemView(addingItem: AddingItemEntity())
        }
    }
}
