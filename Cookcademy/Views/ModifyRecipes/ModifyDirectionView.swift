//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 21.04.2023.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    
    @Binding var direction: Direction
    
    let createAction: ((Direction) -> Void)
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    var body: some View {
            Form {
                TextField("Direction Description", text: $direction.description)
                    .listRowBackground(listBackgroundColor)
                Toggle("Optional", isOn: $direction.isOptional)
                    .listRowBackground(listBackgroundColor)
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(direction)
                        mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .listRowBackground(listBackgroundColor)
            }
            .navigationTitle("Add Direction")
            .foregroundColor(listTextColor)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection =  Direction()
    static var previews: some View {
        NavigationView {
            ModifyDirectionView(component: $emptyDirection) { _ in return }
        }.navigationTitle("Add Direction")
    }
}
