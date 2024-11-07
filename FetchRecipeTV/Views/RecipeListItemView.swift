//
//  RecipeListItem.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/25/24.
//

import SwiftUI

struct RecipeListItemView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(height: 120)
                .padding(.horizontal)
            
            HStack(spacing: 18) {
                
                if let urlString = recipe.photoUrlLarge {
                    ImageView(recipeId: recipe.id ,urlString: urlString)
                        .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(Font.system(size: 22, weight: .semibold, design: .rounded))
                    
                    Text(recipe.cuisine)
                        .font(Font.system(size: 18, weight: .thin, design: .rounded))
                }
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .resizable()
                    .foregroundStyle(Color(.systemBlue))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
                    
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    RecipeListItemView(
        recipe: Recipe(
            id: "123",
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        )
    )
}
