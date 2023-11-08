//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 6.11.2023.
//

import Foundation
import UIKit

protocol MovieDetailInterface: AnyObject {
    func setupUI()
    func addViews()
}


class DetailsViewController: UIViewController{
    
    private var viewModel = MovieDetailViewModel()
    var imdbID: String?
    var imdbID2: String?
    
    var movieImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel : UILabel = {
        var nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 3
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    var yearLabel : UILabel = {
        var yearLabel = UILabel()
        yearLabel.textAlignment = .center
        yearLabel.textColor = .white
        yearLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        return yearLabel
    }()
    var starringsLabel : UILabel = {
        var starringsLabel = UILabel()
        starringsLabel.textAlignment = .center
        starringsLabel.textColor = .white
        starringsLabel.numberOfLines = 0
        starringsLabel.lineBreakMode = .byWordWrapping
        starringsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        starringsLabel.translatesAutoresizingMaskIntoConstraints = false
        return starringsLabel
    }()
    var countryLabel : UILabel = {
        var countryLabel = UILabel()
        countryLabel.textAlignment = .center
        countryLabel.textColor = .white
        countryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryLabel
    }()
    var directorLabel : UILabel = {
        var directorLabel = UILabel()
        directorLabel.textAlignment = .center
        directorLabel.textColor = .white
        directorLabel.text = "Director: "
        directorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        return directorLabel
    }()
    var imdbLabel : UILabel = {
        var imdbLabel = UILabel()
        imdbLabel.textAlignment = .center
        imdbLabel.textColor = .white
        imdbLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        imdbLabel.translatesAutoresizingMaskIntoConstraints = false
        return imdbLabel
    }()
    
    func downloadImageWithKingfisher2(from urlString: String, imageView: UIImageView) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.fetchDetails(id: imdbID ?? "")
        viewModel.fetchDetails(id: imdbID2 ?? "")
        viewModel.viewDidLoad()      
    }
}

extension DetailsViewController: MovieDetailInterface {
    func addViews() {
        view.backgroundColor = .black
        view.addSubview(movieImageView)
        view.addSubview(nameLabel)
        view.addSubview(yearLabel)
        view.addSubview(starringsLabel)
        view.addSubview(countryLabel)
        view.addSubview(directorLabel)
        view.addSubview(imdbLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 75),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 80),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -80),
            movieImageView.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            yearLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 30),
            yearLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            starringsLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor,constant: 30),
            starringsLabel.centerXAnchor.constraint(equalTo: yearLabel.centerXAnchor),
            starringsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            starringsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            countryLabel.topAnchor.constraint(equalTo: starringsLabel.bottomAnchor,constant: 30),
            countryLabel.centerXAnchor.constraint(equalTo: starringsLabel.centerXAnchor),
            
            directorLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor,constant: 30),
            directorLabel.centerXAnchor.constraint(equalTo: countryLabel.centerXAnchor),
            
            imdbLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor,constant: 30),
            imdbLabel.centerXAnchor.constraint(equalTo: directorLabel.centerXAnchor)
               
        ])
    }
    
    func setupUI(){
       
            viewModel.detailsFetched = { [weak self] details in
                if let url = URL(string: details?.poster ?? "") {
                    self?.movieImageView.kf.setImage(with: url)
                }
                self?.nameLabel.text = details?.title
                self?.yearLabel.text = details?.year
                self?.starringsLabel.text = details?.actors
                self?.countryLabel.text = details?.country
                self?.directorLabel.text = "Director: \(details?.director ?? "")"
                self?.imdbLabel.text = "IMDB Rating: \(details?.imdbRating ?? "")"
        }
    }
}
