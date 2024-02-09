//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 28.04.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("listBackgroundColor") private var listBackgroundColor: Color = AppColor.background
    @AppStorage("listTextColor") private var listTextColor: Color = AppColor.foreground
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                ColorPicker("List Background Color", selection: $listBackgroundColor)
                    .listRowBackground(listBackgroundColor)
                    .padding()
                
                ColorPicker("List Text Color", selection: $listTextColor)
                    .listRowBackground(listBackgroundColor)
                    .padding()
                
                Toggle(isOn: $hideOptionalSteps) { Text("Hide optional steps") }
                    .listRowBackground(listBackgroundColor)
                    .padding()
            }
            .foregroundColor(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
