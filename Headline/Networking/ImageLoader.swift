//
//  ImageLoader.swift
//  Headline
//
//  Created by Hugo Pivaral on 15/05/22.
//

import UIKit

typealias ImageCache = [URL : UIImage]
typealias RequestManager = [UUID : URLSessionDataTask]

protocol ImageLoaderProvider {
    
    var cachedImages: ImageCache { get }
    var runningRequests: RequestManager { get }
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelImageLoad(for uuid: UUID)
}

class ImageLoader: ImageLoaderProvider {
    
    // MARK: - Properties
    
    var cachedImages: ImageCache
    var runningRequests: RequestManager
    var compressionEnabled: Bool
    
    
    // MARK: - Initializer
    
    init(compressionEnabled: Bool = true) {
        self.runningRequests = [:]
        self.cachedImages = [:]
        self.compressionEnabled = compressionEnabled
    }
    
    
    // MARK: - Helper methods
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = cachedImages[url] {
            completion(.success(image))
            
            return nil
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        
            defer {
                self?.runningRequests.removeValue(forKey: uuid)
            }
            
            if let data = data,
               let image = UIImage(data: data),
               let compressedData = image.jpegData(compressionQuality: 0),
               let compressedImage = UIImage(data: compressedData) {
                
                self?.cachedImages[url] = self?.compressionEnabled ?? true ?  compressedImage : image
                
                DispatchQueue.main.async {
                    completion(.success(image))
                }
                
                return
            }
            
            guard let error = error else {
                return print("No data & no error 😵‍💫")
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
                return
            }
        }
        
        task.resume()
        
        runningRequests[uuid] = task
        
        return uuid
    }
    
    func cancelImageLoad(for uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}

