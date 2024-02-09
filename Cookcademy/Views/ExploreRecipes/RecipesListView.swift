//
//  ContentView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 05.04.2023.
//

import SwiftUI

struct RecipesListView: View {
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor: Color = AppColor.background
    @AppStorage("listTextColor") private var listTextColor: Color = AppColor.foreground
    
    @EnvironmentObject var recipeData: RecipeData
    
    let viewStyle: ViewStyle
    
    @State var newRecipe = Recipe()
    
    @State private var isPresenting: Bool = false
    
    var body: some View {
            NavigationView {
                List {
                    ForEach(recipes) {recipe in
                            NavigationLink(
                                destination: RecipeDetailView(recipe: binding(for: recipe)),
                                label: {
                                    Text(recipe.mainInformation.name)
                                })
                    }
                    .listRowBackground(listBackgroundColor)
                    .foregroundColor(listTextColor)
                }
                .navigationTitle(navigationTitle)
                .toolbar() {
                    ToolbarItem {
                        Button(action: {
                            newRecipe = Recipe()
                            newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                            isPresenting = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                            .sheet(isPresented: $isPresenting) {
                                NavigationView{
                                    ModifyRecipeView(recipe: $newRecipe)
                                        .navigationTitle("Add a New Recipe")
                                        .toolbar {
                                            ToolbarItem(placement: .cancellationAction) {
                                                Button(action: {
                                                    isPresenting = false
                                                }, label: {
                                                    Text("Dismiss")
                                                })
                                            }
                                            if newRecipe.isValid {
                                                ToolbarItem(placement: .confirmationAction) {
                                                    Button(action: {
                                                        newRecipe.isFavorite = viewStyle == .favorites ? true : false
                                                        recipeData.addRecipe(recipe: newRecipe)
                                                        isPresenting = false
                                                    }, label: {
                                                        Text("Add")
                                                    })
                                                }
                                            }
                                        }
                                }
                            }
                    }
                }
            }
    }
}

extension RecipesListView {
    
    private var recipes: [Recipe] {
        switch viewStyle{
        case let .singleCategory(selectedCategory):
            return recipeData.categorizeRecipes(as: selectedCategory)
        case .favorites:
            return recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle{
        case let .singleCategory(selectedCategory):
            return "\(selectedCategory.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    }
    
    enum ViewStyle: Equatable {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    func binding (for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
            NavigationView {
                RecipesListView(viewStyle: .singleCategory(.breakfast))
                    .environmentObject(RecipeData())
            }
    }
}
