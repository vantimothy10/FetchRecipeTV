//
//  RecipeListViewModelTests.swift
//  FetchRecipeTVTests
//
//  Created by Timothy Van on 11/3/24.
//

import XCTest
@testable import FetchRecipeTV

@MainActor
class RecipeListViewModelTests: XCTestCase {
    var viewModel: RecipeListViewModel!
    var mockManager: MockRecipeDataManager!
    
    override func setUp() {
        super.setUp()
        mockManager = MockRecipeDataManager()
        viewModel = RecipeListViewModel(manager: mockManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockManager = nil
        super.tearDown()
    }
    
    func testFilterRecipesNoFilterNoSearchTerm() async {
        mockManager.recipes = [
            Recipe(id: "1", cuisine: "Italian", name: "Spaghetti", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
            Recipe(id: "2", cuisine: "Japanese", name: "Sushi", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        ]
        await viewModel.fetchRecipes()
        viewModel.filterRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 2)
    }
    
    func testFilterRecipesWithFilterNoSearchTerm() async {
        mockManager.recipes = [
            Recipe(id: "1", cuisine: "Italian", name: "Spaghetti", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
            Recipe(id: "2", cuisine: "Japanese", name: "Sushi", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        ]
        await viewModel.fetchRecipes()
        viewModel.selectedFilter = "Italian"
        viewModel.filterRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.first?.name, "Spaghetti")
    }
    
    func testFilterRecipesNoFilterWithSearchTerm() async {
        mockManager.recipes = [
            Recipe(id: "1", cuisine: "Italian", name: "Spaghetti", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
            Recipe(id: "2", cuisine: "Japanese", name: "Sushi", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        ]
        await viewModel.fetchRecipes()
        viewModel.searchTerm = "Sushi"
        viewModel.filterRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.first?.name, "Sushi")
    }
    
    func testFilterRecipesWithFilterWithSearchTerm() async {
        mockManager.recipes = [
            Recipe(id: "1", cuisine: "Italian", name: "Spaghetti", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
            Recipe(id: "2", cuisine: "Japanese", name: "Sushi", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
            Recipe(id: "3", cuisine: "Japanese", name: "Ramen", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        ]
        await viewModel.fetchRecipes()
        viewModel.selectedFilter = "Japanese"
        viewModel.searchTerm = "Ramen"
        viewModel.filterRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 1)
        XCTAssertEqual(viewModel.filteredRecipes.first?.name, "Ramen")
    }
    
    func testFilterRecipesWithFilterNoMatchingSearchTerm() async {
        mockManager.recipes = [
            Recipe(id: "1", cuisine: "Italian", name: "Spaghetti", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
            Recipe(id: "2", cuisine: "Japanese", name: "Sushi", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        ]
        await viewModel.fetchRecipes()
        viewModel.selectedFilter = "Japanese"
        viewModel.searchTerm = "Pizza"
        viewModel.filterRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)
    }
}
