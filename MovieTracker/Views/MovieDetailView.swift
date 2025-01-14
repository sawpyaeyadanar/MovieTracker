//
//  MovieDetailView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//
import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var model : MovieDetailsViewModel
    
    var body: some View {
        ZStack {
            Color(red: 30 / 255, green: 31 / 255, blue: 50 / 255).ignoresSafeArea()
            let _ = Self._printChanges()
            if model.isOffline {
                VStack {
                    Spacer()
                    Text("Unable to load page.")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                    Text("Please try refreshing later.")
                        .foregroundStyle(.gray)
                    Button("Tap to try again") {
                        model.getMovieCredit()
                        model.loadMovieDetails()
                    }
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        AsyncImage(url: model.movie.backdropURL) { img in
                            img
                                .resizable()
                                .scaledToFill()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        } placeholder: {
                            ProgressView()
                                .frame(height: 400)
                        }
                        
                        HStack {
                            if let details = model.movieDetails {
                                Text(model.movie.title ?? "Movie Name")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                        }
                        
                        HStack {
                            Label("\(String(format: "%.1f", model.movie.vote_average)) >", systemImage: "star.fill")
                                .foregroundStyle(.yellow)
                            
                            HStack(spacing: 8) {
                                if let genres = model.movieDetails?.genres {
                                    ForEach(genres, id: \.self) { type in
                                        GenreTagView(genre: type.name ?? "Unknown")
                                    }
                                }
                            }
                            
                            .padding(.horizontal)
                            Spacer()
                        }
                        HStack {
                            if let releaseDate = model.movie.formattedReleaseDate {
                                Text("Release Date")
                                    .foregroundColor(.white)
                                Spacer()
                                Text(releaseDate)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        HStack {
                            Text("About film")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        Text(model.movie.overview)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("Trailer")
                                .font(.title3)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer()
                            NavigationLink(destination: YoutubeTrailerView()) {
                                Text("See more >")
                                    .font(.footnote)
                            }
                            
                        }
                        
                        VideoPlayerView()
                            .frame(height: 200)
                        
                        if !model.castProfiles.isEmpty {
                            HStack {
                                Text("Cast & Crew")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(model.castProfiles) { profile in
                                        CastView(cast: profile)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .overlay(alignment: .topLeading, content: {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
            .padding(.leading)
            
        })
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .onAppear {
            if !model.isOffline {
                model.getMovieCredit()
                model.loadMovieDetails()
            }
        }
        .onChange(of: model.movieDetails) { newValue in
            print("movieDetails updated: \(String(describing: newValue?.title))")
        }
        
        .onChange(of: model.castProfiles) { newValue in
            print("castProfiles updated: \(newValue.count) profiles")
        }
        
    }
}

#Preview {
    MovieDetailView(model: MovieDetailsViewModel(apiService: APIDetailPreviewClient(), movie: Movie(id: 939243, poster_path: "https://image.tmdb.org/t/p/w300///zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg", title: "Sonic the Hedgehog 3", vote_average: 7.2, overview: "Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched in every way, Team Sonic must seek out an unlikely alliance in hopes of stopping Shadow and protecting the planet.", release_date: "2025-01-09")))
}
