//
//  StorageManager.swift
//  UltimateRacing
//
//  Created by APPLE on 24.12.2023.
//

import UIKit

final class StorageManager {
    
    private let manager = FileManager.default
    
    private func getPathForImage(name: String) -> URL? {
        
        guard let path = manager.urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(name) else {
            return nil
        }
        
        return path
    }
    
    //MARK: - Public
    public func saveImage(_ image: UIImage) throws -> String? {
        
        let name = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(name: name) else {
            return nil
        }

        try data.write(to: path)
        
        return name
    }
    
    public func loadImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              manager.fileExists(atPath: path) else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
}
