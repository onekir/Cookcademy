//
//  ModifyComponentsView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 16.04.2023.
//

import SwiftUI

protocol RecipeComponent: Identifiable, CustomStringConvertible, Codable {
    static func singularName() -> String
    static func pluralName() -> String
    init()
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> () )
}


struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack{
            
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            } .navigationTitle("Add \(Component.singularName().capitalized)")
            
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                VStack {
                    HStack{
                        Text(Component.pluralName().capitalized)
                            .font(.title)
                            .padding()
                            .bold()
                        Spacer()
                        EditButton()
                            .padding()
                    }
                    List {
                        ForEach(components.indices, id: \.self) { index in
                            let editComponentView = DestinationView(component: $components[index]) { _ in return }
                                .navigationTitle("Edit \(Component.singularName().capitalized)")
                            NavigationLink(components[index].description, destination: editComponentView)
                                .listRowBackground(listBackgroundColor)
                        }
                        .onDelete { components.remove(atOffsets: $0) }
                        .onMove { indicies, newOffSet in
                            components.move(fromOffsets: indicies, toOffset: newOffSet)
                        }
                        NavigationLink("Add another \(Component.singularName())", destination: addComponentView)
                            .listRowBackground(listBackgroundColor)
                            .buttonStyle(.plain)
                    }
                }
                .foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifycomponentsView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    @State static var emptyIngredients = Recipe().ingredients
    static var previews: some View {
        NavigationView{
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
        }
        NavigationView{
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $emptyIngredients)
        }
    }
}
