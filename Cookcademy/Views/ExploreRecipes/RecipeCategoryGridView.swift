//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 09.04.2023.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    
    @EnvironmentObject var recipeData: RecipeData
    
    let layout = [
        GridItem(.flexible(minimum: 10)),
        GridItem(.flexible(minimum: 10))
    ]
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView {
                    LazyVGrid(columns: layout, content: {
                        ForEach (MainInformation.Category.allCases, id: \.self) { category in
                            NavigationLink(destination: RecipesListView(viewStyle: .singleCategory(category)), label: {
                                    CategoryView(category: category)
                            })
                        }
                    })
                }
            }
            .navigationTitle("Categories")
            .padding()
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGridView()
    }
}
