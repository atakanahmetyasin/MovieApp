//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 7.11.2023.
//

import Foundation

protocol MovieViewModelInterface {
    func viewDidLoad()
    func fetchBatmanMovies() //test
//    func fetchStarwarsMovies()
}

struct Constants {
    static let API_KEY = "e248f44c"
    static let baseURL = "http://www.omdbapi.com/"
}

class MovieViewModel: MovieViewModelInterface {
    var batmanSearch: [Search] = []
    var filteredSearch: [Search] = []
//    var starWarsSearch: [Search] = []
//    var filteredStarWars: [Search] = []

    var view: MovieViewInterface?
    private let networkManager : MovieService
    let batmanURL = URL(string: "http://www.omdbapi.com/?apikey=e248f44c&s=batman")
    let starwarsURL = URL(string: "http://www.omdbapi.com/?apikey=e248f44c&s=starwars")
    
    init(view: MovieViewInterface,networkManager: MovieService = APIManager.shared ){
        self.view = view
        self.networkManager = networkManager
    }
    
    
    
    func viewDidLoad() {
        
        view?.createCollectionView() //test edilebilir
        view?.setupUI()
    }
    
    func fetchBatmanMovies(){
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=e248f44c&s=batman") else { return }
        networkManager.fetchData(from: url) { [weak self] (result: Result<Movie,Error>) in
            switch result {
            case let .success(response):
                self?.batmanSearch = response.search
                self?.filteredSearch = response.search
                DispatchQueue.main.async { [weak self] in
                    self?.view?.reloadData()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
//    func fetchStarwarsMovies(){
//        guard let url = URL(string: "http://www.omdbapi.com/?apikey=e248f44c&s=starwars") else { return }
//        networkManager.fetchData(from: url) { [weak self] (result: Result<Movie,Error>) in
//            switch result {
//            case let .success(response):
//                self?.starWarsSearch = response.search
//                self?.filteredStarWars = response.search
//                DispatchQueue.main.async { [weak self] in
//                    self?.view?.reloadData()
//                }
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
//
//    }
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
