//
//  CoreDataManager.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/27.
//

import CoreData
import Foundation

final public class CoreDataManager {
    public static let shared = CoreDataManager()
    
    private let persistenceController: PersistenceController
    private let viewContext: NSManagedObjectContext
    
    private init(
        persistenceController: PersistenceController = PersistenceController.shared,
        viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    ) {
        self.persistenceController = persistenceController
        self.viewContext = viewContext
    }
    
    public func add(_ item: ItemEntity) throws {
        let newItem = Item(context: viewContext)
        newItem.title = item.title
        newItem.timestamp = item.timestamp
        newItem.note = item.note
        newItem.created_date = item.createdDate
        newItem.last_edited = item.lastEdited

        try viewContext.save()
        try self.updateStoredItems()
    }
    
    public func delete(_ items: [Item]) throws {
        items.forEach(viewContext.delete)
        
        try viewContext.save()
        try self.updateStoredItems()
    }
    
    public func update(_ item: Item, to: ItemEntity) throws {
        item.title = to.title
        item.timestamp = to.timestamp
        item.note = to.note
        item.last_edited = to.lastEdited
        
        try viewContext.save()
        try self.updateStoredItems()
    }
    
    private func updateStoredItems() throws {
        let items = try viewContext.fetch(Item.fetchRequest())
        let itemEntities = items.map {
            ItemEntity(
                id: $0.objectID.uriRepresentation().absoluteString,
                title: $0.title,
                timestamp: $0.timestamp,
                note: $0.note,
                createdDate: $0.created_date,
                lastEdited: $0.last_edited
            )
        }
        WatchConnectivityManager.shared.send(itemEntities)
    }
    
}
