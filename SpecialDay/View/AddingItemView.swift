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
            let newItem = Item(context: viewContext)
            newItem.title = addingItem.title
            newItem.timestamp = addingItem.timestamp
            newItem.note = addingItem.note
            newItem.created_date = addingItem.createdTimestamp

            do {
                try viewContext.save()
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