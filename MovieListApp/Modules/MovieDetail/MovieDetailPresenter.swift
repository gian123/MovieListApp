//
//  MovieDetailPresenter.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 8/03/23.
//

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol {
    // VIEW -> PRESENTER
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func saveMovie(_ image: UIImage?)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER{AnyObject
    func callBackDidGetSome()
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var router: MovieDetailRouterProtocol?
    
    var data: Result?
    
    init(data: Result) {
        self.data = data
    }
    
    func viewDidLoad() {
        view?.setData(data:data)
    }
    
    func saveMovie(_ image: UIImage?) {
        interactor?.saveMovie(data: data, image: image)
    }
    
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func callBackDidGetSome() {
        
    }
    
    
}
