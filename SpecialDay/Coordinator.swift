//
//  Coordinator.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import Combine
import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func gotoHome() {
        path = NavigationPath()
    }

    func push<V: Hashable>(_ value: V) {
        path.append(value)
    }

    func removeLast(_ count: Int = 1) {
        path.removeLast(count)
    }

}
