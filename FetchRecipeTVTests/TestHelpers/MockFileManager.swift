//
//  MockFileManager.swift
//  FetchRecipeTVTests
//
//  Created by Timothy Van on 11/3/24.
//

import XCTest
@testable import FetchRecipeTV

class MockFileManager: FileManagerProtocol {
    
    var files: [URL: Data] = [:]
    var attributes: [URL: [FileAttributeKey: Any]] = [:]
    
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        return [URL(fileURLWithPath: "/mock/path")]
    }
    
    func write(_ data: Data, to url: URL) throws {
        files[url] = data
    }
    
    func retrieve(at url: URL) throws -> Data {
        return files[url] ?? Data()
    }
    
    func contents(atPath path: String) -> Data? {
        return files[URL(fileURLWithPath: path)]
    }
    
    func removeItem(at url: URL) throws {
        files.removeValue(forKey: url)
        attributes.removeValue(forKey: url)
    }
    
    func attributesOfItem(atPath path: String) throws -> [FileAttributeKey : Any] {
        return attributes[URL(fileURLWithPath: path)] ?? [:]
    }
}
