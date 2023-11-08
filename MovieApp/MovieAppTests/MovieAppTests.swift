//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Ahmet Yasin Atakan on 5.11.2023.
//

import XCTest
@testable import MovieApp

final class MovieViewModelTests: XCTestCase {
    private var viewModel: MovieViewModel!
    private var view: MockMovieViewController!
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(view: view )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_fetchBatmanMovies_fetchData(){
        XCTAssertNotNil(viewModel.fetchBatmanMovies())
    }
    
    func test_ViewModel_viewDidLoad(){
        let viewModel = MovieViewModel(view: view)
        let expectation = XCTestExpectation(description: "viewDidLoad called")
        viewModel.viewDidLoad()
            expectation.fulfill()
        
        wait(for: [expectation], timeout: 5)
    }

    
}
