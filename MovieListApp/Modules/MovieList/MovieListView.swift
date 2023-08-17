//
//  MovieListController.swift
//  TheMovieDBChallenge
//
//  Created by Kevin Candia Villagómez on 7/03/23.
//

import UIKit
import Network

protocol MovieListViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieListPresenterProtocol? { get set }
    func reloadMoviesTable(withData data: MovieListResponse?)
    func reloadCoreDataMoviesTable(withData data: [MoviesCoreData]?)
}

class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: MovieListPresenterProtocol?
    let movieListTableView = UITableView()
    let ofMovieListTableView = UITableView()
    var searchController = UISearchController()
    var elements: MovieListResponse?
    var ofElements = [MoviesCoreData]()
    
    // MARK: - Network check
    var networkCheck = NetworkCheck.sharedInstance()
    
    override func loadView() {
        super.loadView()
        networkCheck.addObserver(observer: self)
        setupUI()
        setupSearchBar()
        if networkCheck.currentStatus == .satisfied {
            ofMovieListTableView.isHidden = true
            callWebService()
        } else {
            movieListTableView.isHidden = true
            callCoreDataService()
        }
        
    }
    
    private func setupUI() {
        // MARK: - ViewConfig
        view.backgroundColor = .white
        title = "The Movie DB(Upcoming)"
        
        // MARK: - MovieList Contrainst
        view.addSubview(movieListTableView)
        view.addSubview(ofMovieListTableView)
        movieListTableView.translatesAutoresizingMaskIntoConstraints = false
        movieListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieListTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        movieListTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        ofMovieListTableView.translatesAutoresizingMaskIntoConstraints = false
        ofMovieListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ofMovieListTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ofMovieListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ofMovieListTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // MARK: - Nib load
        let nib = UINib(nibName: "MovieListTableViewCell", bundle: nil)
        
        // MARK: - Regiter Nib
        movieListTableView.register(nib, forCellReuseIdentifier: MovieListTableViewCell.reusableIdentifier)
        ofMovieListTableView.register(nib, forCellReuseIdentifier: MovieListTableViewCell.reusableIdentifier)

        
        // MARK: - tableViewDelegates
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        ofMovieListTableView.dataSource = self
        ofMovieListTableView.dataSource = self
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Buscador"
        navigationItem.searchController = searchController
    }
    
    private func callWebService() {
        presenter?.getMovieList()
    }
    
    private func callCoreDataService() {
        presenter?.getCoreDataMovieList()
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case movieListTableView:
            return elements?.results?.count ?? 0
        case ofMovieListTableView:
            return ofElements.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reusableIdentifier, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        switch tableView {
        case movieListTableView:
            let data = elements?.results?[indexPath.row]
            cell.overviewLabel.text = data?.overview
            cell.titleMovieLabel.text = data?.title
            cell.releaseDateLabel.text = data?.release_date
            cell.voteAverageLabel.text = String(format: "%.1f", data?.vote_average ?? 0.0)
            cell.posterImageView.af.setImage(withURL: getUrl(data?.poster_path ?? ""))
            return cell
        case ofMovieListTableView:
            let data = ofElements[indexPath.row]
            cell.overviewLabel.text = data.overview
            cell.titleMovieLabel.text = data.title
            cell.releaseDateLabel.text = data.release_date
            cell.voteAverageLabel.text =  String(format: "%.1f", data.vote_average)
            cell.posterImageView.image = UIImage(data: data.imagePoster!)
            return cell
        default:
            return cell
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let item = elements?.results?[indexPath.row] else { return }
        presenter?.presentDetailView(data: item)
    }
    
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter?.filterList(text)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func reloadMoviesTable(withData data: MovieListResponse?) {
        self.elements = data
        DispatchQueue.main.async {
            self.movieListTableView.reloadData()
        }
    }
    
    func reloadCoreDataMoviesTable(withData data: [MoviesCoreData]?) {
        guard let data = data else { return }
//        self.elements?.results = data
        self.ofElements = data
        DispatchQueue.main.async {
//            self.ofMovieListTableView.reloadData()
        }
    }
}

extension MovieListViewController: NetworkCheckObserver {
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            //Do something
        }else if status == .unsatisfied {
            //Show no network alert
        }
    }
}
