//
//  Text+init.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import Foundation
import SwiftUI

extension Text {
    init(_ lang: Lang) {
        self.init(lang.localizedString)
    }
}
