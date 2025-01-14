//
//  YoutubeTrailerView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 14/1/68 BE.
//

import SwiftUI

struct YoutubeTrailerView: View {
    // Sample data for trailers (replace with your actual data model)
    let trailers: [TrailerResult] = [
        TrailerResult(id: "1", title: "Official Trailer", thumbnailURL: "https://image.tmdb.org/t/p/w500/your-thumbnail1.jpg"),
        TrailerResult(id: "2", title: "Official Trailer #2", thumbnailURL: "https://image.tmdb.org/t/p/w500/your-thumbnail2.jpg"),
        TrailerResult(id: "3", title: "Behind the Scenes", thumbnailURL: "https://image.tmdb.org/t/p/w500/your-thumbnail3.jpg")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(trailers) { trailer in
                    VStack {
                        ZStack {
                            // Trailer thumbnail
                            AsyncImage(url: URL(string: trailer.thumbnailURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView()
                                    .frame(height: 200)
                            }
                            
                            // Play button overlay
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                                .opacity(0.8)
                        }
                        
                        // Trailer title
                        Text(trailer.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(Color(red: 30 / 255, green: 31 / 255, blue: 50 / 255).ignoresSafeArea())
    }
}

// Sample Trailer model
struct TrailerResult: Identifiable {
    let id: String
    let title: String
    let thumbnailURL: String
}

#Preview {
    YoutubeTrailerView()
}
