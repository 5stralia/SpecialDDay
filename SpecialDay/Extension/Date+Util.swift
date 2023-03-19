//
//  Date+Util.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import Foundation

public extension Date {
    var dDays: Int {
        let aDaySeconds = Int(TimeInterval.aDaySeconds)
        let timeInterval = -Int(self.timeIntervalSinceNow)

        return (timeInterval / aDaySeconds) + (timeInterval % aDaySeconds > 0 ? 1 : 0)
    }
}
