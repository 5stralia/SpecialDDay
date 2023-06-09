//
//  ItemView.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import SwiftUI

struct ItemView: View {
    let title: String
    let days: Int
    private let isWidget: Bool
    

    init(title: String, days: Int, isWidget: Bool) {
        self.title = title
        self.days = days
        self.isWidget = isWidget
    }

    var body: some View {
        HStack {
            Text(title)
                .bold(isWidget)
                .foregroundColor(isWidget ? .yellow : .primary)
            Spacer()
            Text("\(numberSign(days))\(abs(days)) \(LocalizedStringResource(stringLiteral: "일"))")
                .foregroundColor(daysColor(days))
        }
    }

    private func numberSign(_ number: Int) -> String {
        if number > 0 {
            return "+"
        } else if number == 0 {
            return ""
        } else {
            return "-"
        }
    }

    private func daysColor(_ days: Int) -> Color {
        switch days {
        case ..<0: return .red
        case 0:
            #if os(watchOS)
            return Color(uiColor: .white)
            #elseif os(iOS)
            return Color(uiColor: .label)
            #endif

        default: return .blue
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(title: "title 10000", days: 23455, isWidget: true)
    }
}
