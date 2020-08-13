//
//  MovieRow.swift
//  Swiftui_movie
//
//  Created by Liem Vo on 7/7/19.
//  Copyright © 2019 Liem Vo. All rights reserved.
//

import URLImage
import SwiftUI


struct MovieRow : View {
	var movie: Movie
	
	var body: some View {
		HStack {
			URLImage(URL(string:  "\(BASE_IMAGE_URL)\(movie.poster_path)")!, delay: 0.25) { proxy in
				proxy.image.resizable()
					.frame(width: 90, height: 120)
				
			}
			
			VStack {
				Spacer()
				HStack {
					Text(movie.title)
						.foregroundColor(.blue)
						.lineLimit(nil)
					Spacer()
				}
				HStack {
					Text(movie.release_date).foregroundColor(.gray)
					Spacer()
					Text("Rate: \(movie.vote_average.format())/10")
				}
                Spacer()
				HStack {
                    Text(movie.overview)
						.foregroundColor(.gray)
						.lineLimit(nil)
					Spacer()
				}
                Spacer()
                Button(action: {}){
                        Text("Schedule viewing")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(40)
                    .shadow(color: .gray, radius: 20.0, x: 20, y: 10)
                
				Spacer()
			}
		}.frame(height: 250)
	}
}


