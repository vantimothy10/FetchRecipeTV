//
//  ImageService.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/24/24.
//

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func fetchImage(recipeId: String, imageString: String) async -> UIImage?
}

class ImageService: ImageServiceProtocol {

    private var imageCache: NSCache<NSString, UIImage>
    private var imageDiskCacheService: ImageDiskCacheServiceProtocol
    private let urlSession: URLSession
    
    init(imageCache: NSCache<NSString, UIImage> = .init(), urlSession: URLSession = .shared, imageDiskCacheService: ImageDiskCacheServiceProtocol = ImageDiskCacheService()) {
        self.imageCache = imageCache
        self.urlSession = urlSession
        self.imageDiskCacheService = imageDiskCacheService
    }
    
    func fetchImage(recipeId: String, imageString: String) async -> UIImage? {
        
        // Attempt to retrieve the image from cache
        if let cachedImage = imageCache.object(forKey: recipeId as NSString) {
            print("ImageService: Retrieved image from cache")
            return cachedImage
        }
        
        // Attempt to retrieve the image from disk
        let expirationDate = Date().addingTimeInterval(-60 * 60 * 24) // 1 day expiration
        if let diskImage = imageDiskCacheService.retrieve(forKey: recipeId, expirationDate: expirationDate) {
            print("ImageService: Retrieved image from disk")
            return diskImage
        }
        
        guard let url = URL(string: imageString) else {
            print("ImageService: Failed to parse url" )
            return nil
        }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            
            guard let uiImage = UIImage(data: data) else {
                return nil
            }
            
            // Save the image to cache
            imageCache.setObject(uiImage, forKey: recipeId as NSString)

             // Save the image to disk
            try? imageDiskCacheService.save(image: uiImage, forKey: recipeId)
            
            print("ImageService: Retrieved image from network")
            return uiImage
        } catch  {
            print("ImageService: Request error")
        }
        
        return nil
    }
}
