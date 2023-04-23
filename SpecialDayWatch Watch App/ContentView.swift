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

    var body: some View {
        List(connectivityManager.items, id: \.id) { item in
            ItemView(title: item.title ?? "", days: item.timestamp?.dDays ?? 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
