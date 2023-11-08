//
//  ViewController.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 5.11.2023.
//

import UIKit
import Kingfisher

protocol MovieViewInterface: AnyObject {
    func setupUI()
    func createCollectionView()
    func reloadData()
}

class FirstViewController: UIViewController {
    
    private var myCollectionView: UICollectionView!
    private lazy var viewModel = MovieViewModel(view: self)

    
     var noMovieFoundLabel : UILabel = {
        var noMovieFoundLabel = UILabel()
         noMovieFoundLabel.text = "No Movie Found"
         noMovieFoundLabel.textAlignment = .center
         noMovieFoundLabel.textColor = .red
         noMovieFoundLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
         noMovieFoundLabel.isHidden = true
         noMovieFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        return noMovieFoundLabel
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .clear // Arka plan rengi
        searchBar.searchTextField.backgroundColor = .white // Yazı yazma alanının rengi
        searchBar.searchTextField.leftView?.tintColor = .clear
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray, // Kırmızı placeholder rengi
            .font: UIFont.systemFont(ofSize: 15.0) // İstenilen font
        ]
        searchBar.placeholder = "Search a Movie"
        searchBar.text = "Batman"
        searchBar.layer.cornerRadius = 17.0 // Kenarların yuvarlaklığını ayarla
        searchBar.layer.masksToBounds = true // Kenarların yuvarlaklığını etkinleştir
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white // Yazı yazma alanının rengi
            textField.layer.cornerRadius = 15 // Yazı yazma alanının kenarlarını yuvarlak yap
            textField.layer.masksToBounds = true
        }
         
        return searchBar
    }()

    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        searchBar.delegate = self
        viewModel.fetchBatmanMovies()
//        viewModel.fetchStarwarsMovies()
        
    }
    
    func downloadImageWithKingfisher(from urlString: String, imageView: UIImageView) {
        if let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.filteredSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        return CGSize(width: cellWidth, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        
        downloadImageWithKingfisher(from: viewModel.filteredSearch[indexPath.item].poster, imageView: cell.movieImageView)
        cell.nameLabel.text = viewModel.filteredSearch[indexPath.item].title
        cell.yearLabel.text = viewModel.filteredSearch[indexPath.item].year
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        detailsViewController.imdbID = viewModel.batmanSearch[indexPath.item].imdbID
//        detailsViewController.imdbID2 = viewModel.starWarsSearch[indexPath.item].imdbID
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension FirstViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            noMovieFoundLabel.isHidden = true
            viewModel.filteredSearch = viewModel.batmanSearch
        }
        else{
            noMovieFoundLabel.isHidden = true
            viewModel.filteredSearch = viewModel.batmanSearch.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        if viewModel.filteredSearch.isEmpty{
            noMovieFoundLabel.isHidden = false
           print(noMovieFoundLabel)
            
        }
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
}

extension FirstViewController: MovieViewInterface {
    
    func reloadData() {
        myCollectionView.reloadData()
    }
    
    func setupUI(){
        view.addSubview(searchBar)
        view.addSubview(noMovieFoundLabel)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 1),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -1),
            searchBar.heightAnchor.constraint(equalToConstant: 100),
            
            myCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 5),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noMovieFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noMovieFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
    }
    
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.collectionViewLayout = layout
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
        myCollectionView.backgroundColor = .black
        view.addSubview(myCollectionView)
    }

}


