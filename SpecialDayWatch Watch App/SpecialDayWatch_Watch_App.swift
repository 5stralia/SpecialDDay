//
//  SpecialDayWatchApp.swift
//  SpecialDayWatch Watch App
//
//  Created by Hoju Choi on 2023/03/23.
//

import SwiftUI

@main
struct SpecialDayWatch_Watch_App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
