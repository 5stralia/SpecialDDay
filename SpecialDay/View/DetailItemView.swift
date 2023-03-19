//
//  DetailItemView.swift
//  SpecialDay
//
//  Created by Hoju Choi on 2023/03/19.
//

import CoreData
import SwiftUI

struct DetailItemView: View {
    @EnvironmentObject var coordinator: Coordinator

    @ObservedObject private var addingItem: AddingItemEntity
    private var isShowAlert: Binding<Bool>
    private let doneAction: () -> Void

    init(addingItem: AddingItemEntity, isShowAlert: Binding<Bool>, doneAction: @escaping () -> Void) {
        self.addingItem = addingItem
        self.isShowAlert = isShowAlert
        self.doneAction = doneAction
    }

    var body: some View {
        VStack {
            HStack {
                Text(Lang.title)
                Spacer()
                TextField(Lang.title.string, text: $addingItem.title, prompt: Text("내 생일🎂"))
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled()
            }
            DatePicker("Date", selection: $addingItem.timestamp, displayedComponents: [.date])
            HStack {
                Text(Lang.note)
                Spacer()
                TextField(Lang.note.string, text: $addingItem.note, prompt: Text("잊지말자!"))
                    .multilineTextAlignment(.trailing)
                    .autocorrectionDisabled()
            }
        }
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem {
                Button(action: submitAction) {
                    Text(Lang.done)
                }
            }
        }
        .alert("Error", isPresented: isShowAlert) {
            Button("OK", role: .cancel) {
                coordinator.removeLast()
            }
        }
    }

    private func submitAction() {
        doneAction()
        coordinator.removeLast()
    }
}

struct DetailItemView_Previews: PreviewProvider {
    @State static var isShowAlert: Bool = false

    static var previews: some View {
        DetailItemView(addingItem: AddingItemEntity(), isShowAlert: $isShowAlert, doneAction: { })
    }
}
