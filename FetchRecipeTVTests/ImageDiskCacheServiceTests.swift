//
//  ImageDiskCacheServiceTests.swift
//  FetchRecipeTVTests
//
//  Created by Timothy Van on 11/3/24.
//

import XCTest
@testable import FetchRecipeTV

class ImageDiskCacheServiceTests: XCTestCase {
    var cacheService: ImageDiskCacheService!
    var mockFileManager: MockFileManager!
    
    override func setUp() {
        super.setUp()
        mockFileManager = MockFileManager()
        cacheService = ImageDiskCacheService(fileManager: mockFileManager)
    }
    
    override func tearDown() {
        cacheService = nil
        mockFileManager = nil
        super.tearDown()
    }
    
    func testSave() throws {
        let image = UIImage(systemName: "star")!
        let key = "testKey"
        
        try cacheService.save(image: image, forKey: key)
        
        let directory = mockFileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent(key)
        
        XCTAssertTrue(mockFileManager.files.keys.contains(fileURL))
    }
    
    func testRetrieve() throws {
        let image = UIImage(systemName: "star")!
        let key = "testKey"
        
        try cacheService.save(image: image, forKey: key)
        
        let retrievedImage = cacheService.retrieve(forKey: key, expirationDate: Date().addingTimeInterval(-86400))
        
        XCTAssertNotNil(retrievedImage)
    }
    
    func testRetrieveExpired() throws {
        let image = UIImage(systemName: "star")!
        let key = "testKey"
        
        try cacheService.save(image: image, forKey: key)
        
        let retrievedImage = cacheService.retrieve(forKey: key, expirationDate: Date().addingTimeInterval(0))
        
        XCTAssertNil(retrievedImage)
    }
    

}
