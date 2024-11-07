//
//  ImageDiskCacheService.swift
//  FetchRecipeTV
//
//  Created by Timothy Van on 10/31/24.
//


import Foundation
import UIKit

protocol FileManagerProtocol {
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    func write(_ data: Data, to url: URL) throws
    func retrieve(at url: URL) throws -> Data
}

extension FileManager: FileManagerProtocol {
    func write(_ data: Data, to url: URL) throws {
        try data.write(to: url)
    }
    
    func retrieve(at url: URL) throws -> Data {
        return try Data(contentsOf: url)
    }
}

protocol ImageDiskCacheServiceProtocol {
    func save(image: UIImage, forKey key: String) throws
    func retrieve(forKey key: String, expirationDate: Date) -> UIImage?
}

class ImageDiskCacheService: ImageDiskCacheServiceProtocol {

    private let fileManager: FileManagerProtocol
    
    init(fileManager: FileManagerProtocol = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func save(image: UIImage, forKey key: String) throws {
        guard let data = image.pngData() else {
            throw ImageServiceError.imageConversionFailed
        }
        
        let timestamp = Date().timeIntervalSince1970
        let metadata = ["timestamp": timestamp]
        
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent(key)
        let metadataURL = directory.appendingPathComponent("\(key)_metadata")
        
        do {
            try fileManager.write(data, to: fileURL)
            print("ImageDiskCacheService: Image saved to disk: \(fileURL.path)")
            
            let metadataData = try JSONSerialization.data(withJSONObject: metadata, options: [])
            try fileManager.write(metadataData, to: metadataURL)
            print("ImageDiskCacheService: Metadata saved to disk: \(metadataURL.path)")
            
        } catch {
            throw error
        }
    }
    
    func retrieve(forKey key: String, expirationDate: Date) -> UIImage? {
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent(key)
        let metadataURL = directory.appendingPathComponent("\(key)_metadata")
        
        do {
            let metadataData = try fileManager.retrieve(at: metadataURL)
            if let metadata = try JSONSerialization.jsonObject(with: metadataData, options: []) as? [String: Any],
               let timestamp = metadata["timestamp"] as? TimeInterval {
                
                let savedDate = Date(timeIntervalSince1970: timestamp)
                if savedDate < expirationDate {
                    print("ImageDiskCacheService: retrieved image is expired")
                    return nil
                }
            }
            
            let data = try fileManager.retrieve(at: fileURL)
            return UIImage(data: data)
        } catch {
            print("ImageDiskCacheService: Failed to retrieve image from disk: \(error)")
            return nil
        }
    }
}

enum ImageServiceError: Error {
    case imageConversionFailed
    case fileWriteFailed(Error)
    case metadataWriteFailed(Error)
}
