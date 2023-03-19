//
//  Lang.swift
//  SpecialDay
//
//  Created by Hoju Choi n 2023/03/19.
//

import Foundation
import SwiftUI

enum Lang: String {
    case title = "제목"
    case days = "일"
    case note = "메모"
    case done = "완료"

    var stringLiteral: String {
        self.rawValue
    }

    var localizedString: LocalizedStringResource {
        LocalizedStringResource(stringLiteral: self.stringLiteral)
    }

    var string: String {
        String(localized: self.localizedString)
    }
}
