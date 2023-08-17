//
//  MovieListRouter.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 7/03/23.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol {
    // PRESENTER -> ROUTER
    static func createMovieListModule() -> UIViewController
    
    func presentDetailView(from viewProtocol: MovieListViewProtocol, data: Result)
}

class MovieListRouter: MovieListRouterProtocol {
    static func createMovieListModule() -> UIViewController {
        let viewController = MovieListViewController()
        var presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
        var interactor: MovieListInteractorInputProtocol = MovieListInteractor()
        let router: MovieListRouterProtocol = MovieListRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return viewController
        
    }
    
    func presentDetailView(from viewProtocol: MovieListViewProtocol, data: Result) {
        let routerModule: MovieDetailViewController = MovieDetailRouter.createMovieDetailModule(data: data) as! MovieDetailViewController
        guard let controller = viewProtocol as? UIViewController else {
            return
        }
        controller.navigationController?.pushViewController(routerModule, animated: true)
    }
}
