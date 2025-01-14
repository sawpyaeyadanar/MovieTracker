//
//  SearchResultsView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import SwiftUI

struct SearchResultsView: View {
    let searchResults: [Movie]
    
    var body: some View {
            LazyVStack {
                ForEach(searchResults) { movie in
                    NavigationLink {
                        MovieDetailView(model:  MovieDetailsViewModel(apiService: APIClient(), movie: movie))
                    } label: {
                        SearchView(movie: movie)
                    }
                }
            }
            .padding()
    }
}

#Preview {
    SearchResultsView(searchResults: [Movie(id: 1, poster_path: "https://image.tmdb.org/t/p/w300//vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.2, overview: "", release_date: "2025-01-09"), Movie(id: 1, poster_path: "https://image.tmdb.org/t/p/w300//vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.2, overview: "", release_date: "2025-01-09")])
}

struct SearchView: View {
    let movie: Movie
    var body: some View {
        HStack {
            if let backdrop = movie.backdropURL {
                AsyncImage(url: backdrop) { img in
                    img
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 120)
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 120)
                }
                .clipped()
                .cornerRadius(10)
            } else {
                Image(.placeholder)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 120)
                    .clipped()
            }
            
            VStack(alignment: .leading) {
                Text(movie.title ?? "")
                    .foregroundColor(.white)
                    .font(.headline)
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
                HStack {
                    if let year = movie.year {
                        Text(year)
                        Spacer()
                    }
                }
                .foregroundColor(.yellow)
            }
            Spacer()
            
        }
        .padding()
        .background(Color(red: 61/255, green: 61/255, blue: 88/255))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
