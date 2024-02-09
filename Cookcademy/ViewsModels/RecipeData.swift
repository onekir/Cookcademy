//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 07.04.2023.
//

import Foundation

class RecipeData: ObservableObject {
        
    @Published var recipes: [Recipe] = Recipe.testRecipes
    
    var favoriteRecipes: [Recipe] {
        recipes.filter {$0.isFavorite}
    }
    
    private var recipesFileURL: URL {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return documentDirectory.appendingPathComponent("recipeData")
        }
        catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        }
        catch {
            fatalError("An error occurred while saving recipes: \(error)")
        }
    }
    
    func loadRecipes() {
        //check an ability to read
        guard FileManager.default.isReadableFile(atPath: recipesFileURL.path) else {
            return
        }
        //decoder
        do {
            let data = try Data(contentsOf: recipesFileURL)
            recipes = try JSONDecoder().decode([Recipe].self, from: data)
        }
        catch {
            fatalError("An error occurred while loading recipes: \(error)")
        }
    }
        
    func categorizeRecipes (as selectedCategory: MainInformation.Category) -> [Recipe] {
        var categorizedRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == selectedCategory {
                categorizedRecipes.append(recipe)
            }
        }
        return categorizedRecipes
    }
    
    func addRecipe(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
        saveRecipes()
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
            return i
            }
        }
        return nil
    }
    
}
