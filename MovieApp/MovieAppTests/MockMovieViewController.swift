//
//  MockMovieViewController.swift
//  MovieAppTests
//
//  Created by Ahmet Yasin Atakan on 8.11.2023.
//

import Foundation

@testable import MovieApp

final class MockMovieViewController: MovieViewInterface{
    
    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0
    func setupUI() {
        
    }
    
    func createCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }
    
    func reloadData() {
        
    }
    
    
    
}
