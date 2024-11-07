//
//  ImageServiceTests.swift
//  FetchRecipeTVTests
//
//  Created by Timothy Van on 11/6/24.
//

import XCTest
@testable import FetchRecipeTV

final class ImageServiceTests: XCTestCase {
    var service: ImageService!
    var mockImageDiskCacheService: MockImageDiskCacheService!
    
    override func setUp() {
        super.setUp()
        mockImageDiskCacheService = MockImageDiskCacheService()
        service = ImageService(imageDiskCacheService: mockImageDiskCacheService)
    }
    
    override func tearDown() {
        mockImageDiskCacheService = nil
        service = nil
        super.tearDown()
    }

    func testRetrieveFromCache() async {
        let cache = NSCache<NSString, UIImage>()
        cache.setObject(UIImage(systemName: "star")!, forKey: "testId")
        let service = ImageService(imageCache: cache)
        
        let result = await service.fetchImage(recipeId: "testId", imageString: "")
        
        XCTAssertEqual(result, UIImage(systemName: "star")!)
    }
    
    func testRetrieveFromDiskCache() async {
        mockImageDiskCacheService.imageToReturn = UIImage(systemName: "star")!
        let result = await service.fetchImage(recipeId: "testId", imageString: "")
        
        XCTAssertEqual(result, UIImage(systemName: "star")!)
    }

}
