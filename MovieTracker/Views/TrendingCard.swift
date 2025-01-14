//
//  TrendingCard.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import SwiftUI

struct TrendingCard: View {
    
    let trendingItem: Movie
    
    var body: some View {
        VStack {
            CachedAsyncImage(url: trendingItem.backdropURL)
                .frame(width: 340, height: 200)
            HStack {
                    Text(trendingItem.title ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 15))
                        .fontWeight(.heavy)
                    
                Spacer()
                voteView
            }
            .padding()
            .frame(height: 25)
            .background(.black)
        }
        .cornerRadius(10)

    }
    
    var voteView: some View {
        HStack {
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", trendingItem.vote_average))
                .font(.system(size: 15))
        }
        .padding(.trailing, 8)
        .foregroundColor(.yellow)
        .fontWeight(.heavy)
        
    }
}

#Preview {
    TrendingCard(trendingItem: Movie(id: 1, poster_path: "https://image.tmdb.org/t/p/w300//vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.2, overview: "", release_date: "2025-01-09"))
}
