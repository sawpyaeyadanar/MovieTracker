//
//  MoviesSectionView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 14/1/68 BE.
//

import Foundation
import SwiftUI

struct MoviesSectionView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        if movies.isEmpty {
            Text("No results")
        } else {
            HStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies.removingDuplicates(), id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(model: MovieDetailsViewModel(apiService: APIClient(), movie: movie))
                        } label: {
                            TrendingCard(trendingItem: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MoviesSectionView(title: "Trending", movies: [Movie(id: 1, poster_path: "https://image.tmdb.org/t/p/w300//vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.2, overview: "", release_date: "2025-01-09"), Movie(id: 1, poster_path: "https://image.tmdb.org/t/p/w300//vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.2, overview: "", release_date: "2025-01-09")])
}
