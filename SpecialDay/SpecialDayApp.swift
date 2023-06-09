//
//  SpecialDayApp.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import SwiftUI

@main
struct SpecialDayApp: App {
    let persistenceController = PersistenceController.shared
    @State var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(coordinator)
        }
    }
}
