//
//  CategoryView.swift
//  Cookcademy
//
//  Created by Александр Кириченко on 09.04.2023.
//

import SwiftUI

struct CategoryView: View {
    
    let category: MainInformation.Category
    
    var body: some View {
        ZStack{
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorMultiply(.gray.opacity(0.80))
            Text(category.rawValue)
                .font(.title)
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
            CategoryView(category: .breakfast)
    }
}
