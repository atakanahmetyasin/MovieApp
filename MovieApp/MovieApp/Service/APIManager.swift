//
//  APIManager.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 6.11.2023.
//

import Foundation

class APIManager: MovieService {
    
    static var shared = APIManager()
    
    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError()))
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

