//
//  MovieLoginPresenter.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 7/03/23.
//

import Foundation

protocol MovieLoginPresenterProtocol {
    // VIEW -> PRESENTER
    var view: MovieLoginViewProtocol? { get set }
    var interactor: MovieLoginInteractorInputProtocol? { get set }
    var router: MovieLoginRouterProtocol? { get set }
    
    func callLogin(_ user: String, _ password: String)
}

protocol MovieLoginInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func callBackDidGetUser()
    func callBackDidGetError()
}

class MovieLoginPresenter: MovieLoginPresenterProtocol{
    
    //MARK: Properties
    weak var view: MovieLoginViewProtocol?
    var interactor: MovieLoginInteractorInputProtocol?
    var router: MovieLoginRouterProtocol?

    func callLogin(_ user: String, _ password: String) {
        interactor?.callLogin2(user, password)
    }
}

extension MovieLoginPresenter: MovieLoginInteractorOutputProtocol {
    func callBackDidGetUser() {
        router?.presentListView(from: self.view!)
    }
    
    func callBackDidGetError() {
        view?.callBackWithNotSuccess()
    }
}
