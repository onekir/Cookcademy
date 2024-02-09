//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 11.04.2023.
//

import SwiftUI

struct ModifyRecipeView: View {
    
    @Binding var recipe: Recipe
    
    @State private var isPresenting: Bool = false
    
    @State private var formPicker: Selection = .main
    
    enum Selection: String, CaseIterable {
        case main = "Main info"
        case ingredients = "Ingredients"
        case directions = "Directions"
    }
    
    var body: some View {
        VStack {
            Picker("Form", selection: $formPicker) {
                ForEach(Selection.allCases, id: \.self) { selection in
                    Text(selection.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch formPicker {
            case .main:
                ModifyMainInformationView(mainInformation: $recipe.mainInformation)
            case .ingredients:
                ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
            case .directions:
                ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions)
            }
        }
        .padding()
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe: Recipe = Recipe()
    static var previews: some View {
        NavigationView {
            ModifyRecipeView(recipe: $recipe)
                .navigationTitle("Add a New Recipe")
        }
    }
}
