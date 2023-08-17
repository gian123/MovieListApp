//
//  MovieDetailInteractor.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 8/03/23.
//

import Foundation
import UIKit

protocol MovieDetailInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    
    func saveMovie(data: Result?, image: UIImage?)
}

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: MovieDetailInteractorOutputProtocol?
    
    func saveMovie(data: Result?, image: UIImage?) {
        let service = CoredataRepository()
        guard let image = image else { return }
        service.saveMovieCoreData(withMovie: data!, withImage: image)
    }
    
}
