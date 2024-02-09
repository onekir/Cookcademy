//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 15.04.2023.
//

import SwiftUI

struct ModifyMainInformationView: View {
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
                Form {
                    Section {
                        TextField("Recipe Name", text: $mainInformation.name)
                            .listRowBackground(listBackgroundColor)
                        TextField("Author", text: $mainInformation.author)
                            .listRowBackground(listBackgroundColor)
                    }
                    Section("DESCRIPTION") {
                        TextField("", text: $mainInformation.description)
                            .listRowBackground(listBackgroundColor)
                    }
                    Section {
                        Picker("Category", selection: $mainInformation.category) {
                            ForEach(MainInformation.Category.allCases, id: \.self) { category in
                                Text(category.rawValue)
                            }
                        }
                        .listRowBackground(listBackgroundColor)
                    }
                }
                .foregroundColor(listTextColor)
        }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInformation: MainInformation = MainInformation(name: "Recipe Name", description: "", author: "Author", category: .breakfast)
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $mainInformation)
    }
}
