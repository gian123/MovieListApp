//
//  MovieDetailViewController.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 8/03/23.
//

import UIKit
import Alamofire
import AlamofireImage

protocol MovieDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func setData(data: Result?)
}

class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenterProtocol?

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        presenter?.viewDidLoad()
    }

    private func saveMovie(_ image: UIImage?) {
        presenter?.saveMovie(image)
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func setData(data: Result?) {
        guard let posterPath = data?.poster_path, let movieTitle = data?.title, let date = data?.release_date, let average = data?.vote_average, let overview = data?.overview else { return }
        movieTitleLabel.text = movieTitle
        releaseDateLabel.text = date
        voteAverageLabel.text = String(average)
        overviewLabel.text = overview
        posterImageView.af.setImage(withURL: getUrl(posterPath))
        var image = posterImageView.image
        saveMovie(image)
    }
    
}
