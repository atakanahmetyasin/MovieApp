//
//  MovieService.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 6.11.2023.
//

import Foundation

protocol MovieService {
    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T,Error>) -> Void)
    
}
