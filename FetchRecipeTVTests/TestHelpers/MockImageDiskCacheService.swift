//
//  MockImageDiskCacheService.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 11/6/24.
//

import UIKit
@testable import FetchRecipeTV

class MockImageDiskCacheService: ImageDiskCacheServiceProtocol {
    var imageToReturn: UIImage?
    
    init(imageToReturn: UIImage? = UIImage(systemName: "star")!) {
        self.imageToReturn = imageToReturn
    }

    
    func save(image: UIImage, forKey key: String) throws {
        return
    }
    
    func retrieve(forKey key: String, expirationDate: Date) -> UIImage? {
        return imageToReturn
    }
    

}
