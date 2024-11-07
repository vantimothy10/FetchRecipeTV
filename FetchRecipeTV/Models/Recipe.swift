//
//  Recipe.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/24/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    var hasNoUrls: Bool {
        return sourceUrl == nil && youtubeUrl == nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
