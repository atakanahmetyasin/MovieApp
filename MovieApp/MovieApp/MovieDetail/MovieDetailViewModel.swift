//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 8.11.2023.
//

import Foundation

protocol MovieDetailViewModelInterface {
    var view: MovieDetailInterface? { get set }
    func viewDidLoad()
    func fetchDetails(id: String)
    
}

class MovieDetailViewModel: MovieDetailViewModelInterface {
    weak var view: MovieDetailInterface?
    private let networkManager = APIManager.shared
    var detailsFetched: ((MovieIMDB?) -> Void)?
    
    func viewDidLoad() {
        view?.addViews()
        view?.setupUI()
    }
    
    func fetchDetails(id: String){
        
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=e248f44c&i=\(id)&plot=full") else { return }
        networkManager.fetchData(from: url) { [weak self] (result: Result<MovieIMDB, Error>) in
            switch result{
            case let .success(response):
                DispatchQueue.main.async { [weak self] in
                    self?.detailsFetched?(response)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
