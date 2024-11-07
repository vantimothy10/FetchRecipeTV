//
//  FetchRecipeTVApp.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/24/24.
//

import SwiftUI

@main
struct FetchRecipeTVApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: RecipeListViewModel())
        }
    }
}
