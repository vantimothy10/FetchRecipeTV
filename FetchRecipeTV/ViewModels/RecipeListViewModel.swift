//
//  RecipeListViewModel.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 11/3/24.
//

import SwiftUI

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var searchTerm: String = ""
    @Published var selectedFilter: String?
    @Published var selectedRecipe: Recipe?
    var cuisines: [String] = []
    
    let manager: RecipeDataManagerProtocol
    
    init(recipes: [Recipe] = [], manager: RecipeDataManagerProtocol = RecipeDataManager()) {
        self.recipes = recipes
        self.manager = manager
        
        Task {
            await fetchRecipes()
        }
    }
    
    func fetchRecipes() async {
        do {
            recipes = try await manager.getRecipes()
            let cuisineArray = recipes.map{ $0.cuisine }
            cuisines = Array(Set(cuisineArray)).sorted()
            withAnimation(.easeInOut(duration: 0.25)){
                filteredRecipes = []
            }
            
            withAnimation(.easeInOut(duration: 0.25).delay(0.30)){
                filteredRecipes = recipes
            }

        } catch {
            print(error)
            recipes = []
        }
            
    }
    
    func filterRecipes() {
        var filtered = recipes
        
        // Filter cuisine based on filter chip selection
        if let selectedCuisine = selectedFilter {
            filtered = filtered.filter { $0.cuisine.lowercased().contains(selectedCuisine.lowercased())}
        }
        
        // Return early if the search term is blank
        guard searchTerm != "" else {
            filteredRecipes = filtered
            return
        }
        
        // Filter for dish name or cuisine by search term
        filteredRecipes = filtered.filter{
            $0.name.lowercased().contains(searchTerm.lowercased()) ||
            $0.cuisine.lowercased().contains(searchTerm.lowercased())
        }
    }
    
}
