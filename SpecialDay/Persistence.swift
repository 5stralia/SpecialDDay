//
//  Persistence.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let testData = TestData()

        for itemEntity in testData.items {
            let newItem = Item(context: viewContext)
            newItem.title = itemEntity.title
            newItem.timestamp = itemEntity.timestamp
            newItem.note = itemEntity.note
            newItem.created_date = itemEntity.createdDate
        }
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
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SpecialDay")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible,
                   due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

struct TestData {
    let items: [TextItemData]

    // swiftlint:disable function_body_length
    init() {
        let now = Date()
        self.items = [
            TextItemData(
                title: "title 1",
                timestamp: Date(timeInterval: -100 * .aDaySeconds, since: now),
                note: "note 1",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 2",
                timestamp: Date(timeInterval: -90 * .aDaySeconds, since: now),
                note: "note 2",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 3",
                timestamp: Date(timeInterval: -45 * .aDaySeconds, since: now),
                note: "note 3",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 4",
                timestamp: Date(timeInterval: 0 * .aDaySeconds, since: now),
                note: "note 4",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 5",
                timestamp: Date(timeInterval: 55 * .aDaySeconds, since: now),
                note: "note 5",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 6",
                timestamp: Date(timeInterval: 100 * .aDaySeconds, since: now),
                note: "note 6",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 7",
                timestamp: Date(timeInterval: 1027 * .aDaySeconds, since: now),
                note: "note 7",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 8",
                timestamp: Date(timeInterval: 59348 * .aDaySeconds, since: now),
                note: "note 8",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 9",
                timestamp: Date(timeInterval: -23940 * .aDaySeconds, since: now),
                note: "note 9",
                createdDate: Date()
            ),
            TextItemData(
                title: "title 10",
                timestamp: Date(timeInterval: 0 * .aDaySeconds, since: now),
                note: "note 10",
                createdDate: Date()
            )
        ]
    }
    // swiftlint:enable function_body_length
}

struct TextItemData {
    let title: String
    let timestamp: Date
    let note: String
    let createdDate: Date
}
