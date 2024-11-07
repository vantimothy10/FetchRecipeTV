//
//  ImageView.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/24/24.
//

import SwiftUI


struct ImageView: View {
    @State var uiImage: UIImage?
    
    let recipeId: String
    let urlString: String
    let imageService: ImageServiceProtocol
    
    init(uiImage: UIImage? = nil, recipeId: String, urlString: String, imageService: ImageServiceProtocol = ImageService()) {
        self.uiImage = uiImage
        self.recipeId = recipeId
        self.urlString = urlString
        self.imageService = imageService
    }
    
    var body: some View {
        VStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 2)
                        .fill(.ultraThinMaterial)
                        .frame(width: 100, height: 100)
                    Image(systemName: "photo.fill")
                }
            }
        }
        .task {
            uiImage = await imageService.fetchImage(recipeId: recipeId, imageString: urlString)
        }

        
    }
}

#Preview {
    ImageView(recipeId: "test", urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/376f3377-c481-43cf-bcc6-c0befd612552/large.jpg")
}
