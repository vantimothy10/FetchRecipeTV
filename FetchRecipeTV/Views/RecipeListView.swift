//
//  RecipeListView.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/24/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationStack {
            VStack {

                ScrollView {
                    LazyVStack() {
                        FilterChipContainerView(selectedItem: $viewModel.selectedFilter, items: viewModel.cuisines)
                        if !viewModel.recipes.isEmpty {
                            ForEach(viewModel.filteredRecipes) { recipe in
                                RecipeListItemView(recipe: recipe)
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.selectedRecipe = recipe
                                            print(recipe)
                                        }
                                    }

                            }
                        } else {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .frame(height: 100)
                                .padding(.horizontal)
                                .overlay {
                                    Text("No Recipes Found")
                                        .font(Font.system(size: 24, weight: .light, design: .rounded))
                                        .foregroundStyle(.gray)
                                }
                        }
                        
                    }
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("Recipes")
                .scrollBounceBehavior(.basedOnSize)
                .searchable(text: $viewModel.searchTerm)
                .onChange(of: viewModel.searchTerm, { _, _ in
                    withAnimation {
                        viewModel.filterRecipes()
                    }
                    
                })
                .onChange(of: viewModel.selectedFilter, { _, _ in
                    withAnimation {
                        viewModel.filterRecipes()
                    }
                    
                })
                .refreshable {
                    
                    await viewModel.fetchRecipes()
                }
                .sheet(item: $viewModel.selectedRecipe) { recipe in
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                        HStack {
                            
                            if let sourceURLString = recipe.sourceUrl, let sourceURL = URL(string: sourceURLString) {
                                Button {
                                    openURL(sourceURL)
                                } label: {
                                    Label("Recipe Link", systemImage: "scroll")
                                        .labelStyle(.titleAndIcon)
                                        .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Color(.systemBlue))
                                }
                            }
                            
                            if let youtubeURLString = recipe.youtubeUrl, let youtubeURL = URL(string: youtubeURLString) {
                                Button {
                                    openURL(youtubeURL)
                                } label: {
                                    Label("Video Link", systemImage: "play.rectangle")
                                        .labelStyle(.titleAndIcon)
                                        .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                                        .foregroundStyle(Color(.systemBlue))
                                }
                            }
                            
                            if recipe.hasNoUrls {
                                Text("No source or youtube links found")
                                    .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                            }
                            
                        }
                        
                        

                    }
                    .presentationDetents([.fraction(0.15)])
                        
                }
                
            }
        }
    }
}

#Preview {
    RecipeListView(viewModel: RecipeListViewModel())
}
