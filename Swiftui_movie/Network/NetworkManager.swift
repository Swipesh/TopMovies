//
//  NetworkManager.swift
//  Swiftui_movie
//
//  Created by Liem Vo on 7/7/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import Alamofire
import Foundation
import Combine

let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"
class NetworkManager: ObservableObject {
	@Published var movies = MovieList(results: [])
	@Published var loading = false
	private let api_key = "66723597a04dcf8f92a08aa6b3885f49"
	private let api_url_base = "https://api.themoviedb.org/3/discover/movie?primary_release_year=2019&sort_by=popularity.desc&api_key="
	init() {
		loading = true
		loadDataByAlamofire()
	}
	
	private func loadDataByAlamofire() {
		Alamofire.request("\(api_url_base)\(api_key)")
			.responseJSON{ response in
				guard let data = response.data else { return }
				let movies = try! JSONDecoder().decode(MovieList.self, from: data)
				DispatchQueue.main.async {
					self.movies = movies
					self.loading = false
				}
		}
	}
}
