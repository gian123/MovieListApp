//
//  MovieListPresenter.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 7/03/23.
//

import Foundation

protocol MovieListPresenterProtocol {
    // VIEW -> PRESENTER
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }
        
    func getMovieList()
    func getCoreDataMovieList()
    func presentDetailView(data: Result)
    func filterList(_ text: String)
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func callBackDidGetMovies(data: MovieListResponse?)
    func callBachDidGetCoreDataMovies(data: [MoviesCoreData]?)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var router: MovieListRouterProtocol?
    
    var filteredList: MovieListResponse?

    func getMovieList() {
        interactor?.fetchMovies()
    }
    
    func getCoreDataMovieList() {
        interactor?.fetchCoreDataMovies()
    }
    
    func presentDetailView(data: Result) {
        router?.presentDetailView(from: self.view!, data: data)
    }
    
    func filterList(_ text: String) {
        filteredList?.results?.removeAll()
        if text.count != 0 {
            for i in interactor?.movies?.results ?? [] {
                let range = i.title?.lowercased().range(of: text, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    filteredList?.results?.append(i)
                }
            }
        } else {
            filteredList = interactor?.movies
        }
        view?.reloadMoviesTable(withData: filteredList)
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func callBackDidGetMovies(data: MovieListResponse?) {
        view?.reloadMoviesTable(withData: data)
    }
    
    func callBachDidGetCoreDataMovies(data: [MoviesCoreData]?) {
        view?.reloadCoreDataMoviesTable(withData: data)
    }
    
}
