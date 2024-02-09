//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 16.04.2023.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    
    @Binding var ingredient: Ingredient
    
    let createAction: ((Ingredient) -> Void)
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void ) {
        self._ingredient = component
        self.createAction = createAction
    }

    var body: some View {
        VStack{
            Form {
                Section {
                    TextField("Ingredient name", text: $ingredient.name)
                        .listRowBackground(listBackgroundColor)
                    
                    Stepper(value: $ingredient.quantity, in: 0...1000, step: 0.5) {
                        HStack {
                            Text("Quantity: ")
                            TextField("Quantity",
                                      value: $ingredient.quantity,
                                      formatter: NumberFormatter.decimal)
                            .keyboardType(.numbersAndPunctuation)
                        }
                    }
                    .listRowBackground(listBackgroundColor)
                    
                    Picker("Units", selection: $ingredient.unit) {
                        ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .listRowBackground(listBackgroundColor)
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Save") {
                            createAction(ingredient)
                            mode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    .listRowBackground(listBackgroundColor)
                }
            }
            .foregroundColor(listTextColor)
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var emptyIngredient = Ingredient()
    static var previews: some View {
        NavigationView {
            ModifyIngredientView(component: $emptyIngredient) { ingredient in
                print(ingredient)
            }
        }.navigationTitle("Add Ingredient")
    }
}
