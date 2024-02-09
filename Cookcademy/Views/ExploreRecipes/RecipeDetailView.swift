//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 07.04.2023.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor: Color = AppColor.background
    @AppStorage("listTextColor") private var listTextColor: Color = AppColor.foreground
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    private let headerColor: Color = AppColor.listHeaderColor
    
    @EnvironmentObject var recipeData: RecipeData
    
    @Binding var recipe: Recipe
    
    @State private var isPresenting: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            
            List{
                Section(header: Text("Ingredients").foregroundColor(headerColor)){
                    ForEach(recipe.ingredients) { ingredient in
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }
                .listRowBackground(listBackgroundColor)
                
                Section(header: Text("Directions").foregroundColor(headerColor)) {
                        ForEach(hideOptionalSteps ? recipe.requiredDirections.indices : recipe.directions.indices, id: \.self) { index in
                            let direction: Direction = hideOptionalSteps ? recipe.requiredDirections[index] : recipe.directions[index]
                            HStack {
                                Text("\(index + 1).")
                                    .bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")\(direction.description)")
                            }
                        }
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button(action: {
                        recipe.isFavorite.toggle()
                    }, label: {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    })
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("")
                        }
                    }
                    .navigationTitle("Edit Recipe")
            }
            .onDisappear {
                recipeData.saveRecipes()
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe: Recipe = Recipe.testRecipes[1]
    static var previews: some View {
          NavigationView {
              RecipeDetailView(recipe: $recipe)
          }
    }
}
