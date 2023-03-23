//
//  ContentView.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var coordinator: Coordinator

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.created_date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            List {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        ItemView(title: item.title ?? "", days: item.timestamp?.dDays ?? 0)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationDestination(for: Item.self) { item in
                EdittingItemView(
                    addingItem: AddingItemEntity(
                        title: item.title ?? "",
                        timestamp: item.timestamp ?? Date(),
                        note: item.note ?? "",
                        createdTimestamp: item.created_date ?? Date()),
                    item: item
                )
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            }
            .navigationDestination(for: AddingItemEntity.self) { entity in
                AddingItemView(addingItem: entity)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        coordinator.push(AddingItemEntity())
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button {
                        let itemEntities = self.items.map {
                            ItemEntity(title: $0.title, timestamp: $0.timestamp, note: $0.note, createdDate: $0.created_date)
                        }
                        WatchConnectivityManager.shared.send(itemEntities)
                    } label: {
                        Label("Update Watch App", systemImage: "arrow.clockwise")
                    }
                }
            }
//            .onAppear {
//                let itemEntities = self.items.map {
//                    ItemEntity(title: $0.title, timestamp: $0.timestamp, note: $0.note, createdDate: $0.created_date)
//                }
//                WatchConnectivityManager.shared.send(itemEntities)
//            }
        }
    }

    private func updateItem(_ offset: Int, value: AddingItemEntity) {
        withAnimation {
            let item = items[offset]
            item.setValue(value.title, forKey: "title")
            item.setValue(value.timestamp, forKey: "timestamp")
            item.setValue(value.note, forKey: "note")

            do {
                try viewContext.save()
            } catch let error {
                print(error)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
