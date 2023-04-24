//
//  ContentView.swift
//  SpecialDayWatch Watch App
//
//  Created by Hoju Choi on 2023/03/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.created_date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var widgetItem: ItemEntity?

    var body: some View {
        List(connectivityManager.items, id: \.id) { item in
            ItemView(title: item.title ?? "", days: item.timestamp?.dDays ?? 0, isWidget: item.id == widgetItem?.id)
                .onTapGesture {
                    widgetItem = item
                    if let data = try? JSONEncoder().encode(item) {
                        UserDefaults.standard.set(data, forKey: "widget_item")
                    }
                }
        }
        .onAppear {
            if let data = UserDefaults.standard.value(forKey: "widget_item") as? Data,
               let item = try? JSONDecoder().decode(ItemEntity.self, from: data) {
                widgetItem = item
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
