//
//  MockRecipeDataManager.swift
//  FetchRecipeTVTests
//
//  Created by Timothy Van on 11/3/24.
//

import Foundation
@testable import FetchRecipeTV

class MockRecipeDataManager: RecipeDataManagerProtocol {
    var recipes: [Recipe] = []
    
    func getRecipes() async throws -> [Recipe] {
        return recipes
    }
}
