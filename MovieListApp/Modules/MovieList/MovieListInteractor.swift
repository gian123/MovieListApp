//
//  MovieListInteractor.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 7/03/23.
//

import Foundation

protocol MovieListInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var movies: MovieListResponse? { get set }
    func fetchMovies()
    func fetchCoreDataMovies()
}

class MovieListInteractor: MovieListInteractorInputProtocol {
    
    // MARK: - Properties
    weak var presenter: MovieListInteractorOutputProtocol?
    
    var movies: MovieListResponse?
    func fetchMovies() {
        let service = MovieRepository()
        service.fetchMovies { [weak self] listOfMovies in
            guard let self = self else { return }
            self.movies = listOfMovies
            self.presenter?.callBackDidGetMovies(data: listOfMovies)
        }
    }
    
    func fetchCoreDataMovies() {
        let service = CoredataRepository()
        service.fetchCoraDataMovies { [weak self] listOfCoreDataMovies in
            guard let self = self else { return }
            self.presenter?.callBachDidGetCoreDataMovies(data: listOfCoreDataMovies)
        }
    }
}
