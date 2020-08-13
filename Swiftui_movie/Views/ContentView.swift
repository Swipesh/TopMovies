//
//  ContentView.swift
//  Swiftui_movie
//
//  Created by Liem Vo on 7/7/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//
import Foundation
import SwiftUI

struct ContentView : View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        HStack {
            if networkManager.loading {
                Text("Loading ...")
            } else {
                List(networkManager.movies.results) {
                    movie in MovieCard(movie: movie)
                }
            }
        }
        
    }
}
