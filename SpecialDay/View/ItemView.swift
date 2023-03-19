//
//  ItemView.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import SwiftUI

struct ItemView: View {
    let entity: ItemEntity

    init(_ entity: ItemEntity) {
        self.entity = entity
    }
    var body: some View {
        HStack {
            Text(entity.title)
            Spacer()
            Text( "\(abs(entity.days)) \(LocalizedStringResource(stringLiteral: "일"))")
                .foregroundColor(daysColor(entity.days))
        }
    }

    private func daysColor(_ days: Int) -> Color {
        switch days {
        case ..<0: return .red
        case 0: return Color(uiColor: .label)
        default: return .blue
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(ItemEntity(title: "title 10000", days: 23455))
    }
}
