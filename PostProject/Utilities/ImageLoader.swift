//
//  ImageLoader.swift
//  PostProject
//
//  Created by Hemant Shrestha on 20/08/2024.
//

import UIKit

class ImageLoader {
    private var task: URLSessionDataTask?
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}
