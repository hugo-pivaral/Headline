//
//  NetworkingClient.swift
//  Headline
//
//  Created by Hugo Pivaral on 5/07/22.
//

import Foundation

final class NetworkingClient {
    
    /// Performs a GET request to the specified endpoint URL.
    func performRequest<T: Decodable>(to url: URL, withType responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("‣ New GET request to \(url)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
            catch (let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
