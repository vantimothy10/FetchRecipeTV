//
//  RecipeTests.swift
//  FetchRecipeTVTests
//
//  Created by Timothy Van on 11/6/24.
//

import XCTest
@testable import FetchRecipeTV

final class RecipeTests: XCTestCase {

    func testRecipeObjectHasNoUrl() {
        let recipe = Recipe(id: "1", cuisine: "Italian", name: "Pizza", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        
        XCTAssertTrue(recipe.hasNoUrls)
    }
    
    func testRecipeObjectHasUrl() {
        let recipe = Recipe(id: "1", cuisine: "Italian", name: "Pizza", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: "youtube url")
        
        XCTAssertFalse(recipe.hasNoUrls)
    }

}
