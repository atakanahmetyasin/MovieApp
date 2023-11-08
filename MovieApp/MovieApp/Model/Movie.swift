//
//  Movie.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 6.11.2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let search: [Search]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year: String
    let imdbID: String?
    let type: String?
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

