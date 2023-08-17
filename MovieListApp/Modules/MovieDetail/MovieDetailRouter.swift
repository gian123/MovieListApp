//
//  MovieDetailRouter.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 8/03/23.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    // PRESENTER -> ROUTER
    static func createMovieDetailModule(data: Result) -> UIViewController
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    static func createMovieDetailModule(data: Result) -> UIViewController {
        let viewController = MovieDetailViewController()
        var presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter(data: data)
        var interactor: MovieDetailInteractorInputProtocol = MovieDetailInteractor()
        let router: MovieDetailRouterProtocol = MovieDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return viewController
    }
    
}
