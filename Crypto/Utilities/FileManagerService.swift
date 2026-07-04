//
//  FileManagerService.swift
//  Crypto
//
//  Created by Mohammed on 7/4/26.
//

import Foundation

struct FileManagerService {
    static let shared = FileManagerService()
    private let fm = FileManager.default
    
    private init() { }
    
    func createDirectory(for name: String, conformingTo type: DirectoryType) -> URL? {
        let directUrl = switch type {
        case .caches:
            URL.cachesDirectory.appendingPathComponent(name)
        }

        if !fm.fileExists(atPath: directUrl.path()) {
            do {
                try fm.createDirectory(at: directUrl, withIntermediateDirectories: true)
            } catch {
//                print("Failed to create \(name) directory:\n\(error)")
                return nil
            }
        }
        
        return directUrl
    }
    
    func getData(for key: String, from directory : URL) -> Data? {
        let dataUrl = directory.appending(path: key)
        
        do {
            return try Data(contentsOf: dataUrl)
            
        } catch {
//            print("Failed to load data from \(key) file:\n\(error)")
            return nil
        }
    }
    
    func saveData(_ data: Data, for key: String, to directory: URL) {
        let dataUrl = directory.appending(path: key)
        
        do {
            try data.write(to: dataUrl, options: [.atomic, .completeFileProtection])
        } catch {
//            print("Failed to write data itno \(key) file:\n\(error)")
        }
    }
}

enum DirectoryType {
    case caches
}

enum FileError: Error {
    case directoryNotFound
}
