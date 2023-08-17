//
//  Constants.swift
//  MovieListApp
//
//  Created by Jesus Gianfranco Gutierrez Jarra on 16/08/23.
//


import Foundation

struct Constants {
    public static let api_Key = "fa407dc11b8d3580f2a8e0c642261e8f"
    public static let movieLoginURL = "https: //api.themoviedb.org/3/login"
    public static let fetchMoviesURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(api_Key)&language=en-US&"
}

func getUrl(_ urlString: String) -> URL {
    let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)")
    return url ?? URL(string: "")!
}

