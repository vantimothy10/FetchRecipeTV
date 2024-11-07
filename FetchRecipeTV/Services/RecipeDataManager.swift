//
//  RecipeDataManager.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/24/24.
//

import Foundation

protocol RecipeDataManagerProtocol {
    func getRecipes() async throws -> [Recipe]
}

actor RecipeDataManager: RecipeDataManagerProtocol {
    var recipes: [Recipe] = []
    var urlSession: URLSession
    
    init(recipes: [Recipe] = [], urlSession: URLSession = URLSession.shared) {
        self.recipes = recipes
        self.urlSession = urlSession
    }
    
    func getRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await urlSession.data(from: url)
        let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
        
        return decoded.recipes
    }
}

