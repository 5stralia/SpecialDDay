//
//  ContentView.swift
//  SpecialDayWatch Watch App
//
//  Created by Hoju Choi on 2023/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    
    var body: some View {
        List(connectivityManager.items, id: \.title) { item in
            ItemView(title: item.title ?? "", days: item.timestamp?.dDays ?? 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
