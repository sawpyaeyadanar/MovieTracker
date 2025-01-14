//
//  ContentView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import SwiftUI
import CoreData
import Kingfisher

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel : HomeViewModel
    @State var searchText = ""
    @State var showMovieDetail: Bool = false
    @State var currentIndex: Int = 0 //ANIMATED VIEW
    @State var currentCardSize: CGSize = .zero
    @State private var selectedMovie: Movie?
    @Namespace var animation
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack {
            VStack(spacing: 0) {
                searchBox
                    .padding(.vertical, 8)
                    .background(Color.darkNavyBlue)
                
                ScrollView {
                    VStack {
                        ErrorView(errorMessage: viewModel.errorMessage ?? "")
                            .isHidden(viewModel.errorMessage == "", remove: true)
                        
                        Text("You are offline.\(viewModel.trendings.isEmpty ? "" : " Showing saved data.")")
                            .foregroundStyle(.yellow)
                            .padding()
                            .isHidden(!viewModel.isOffline, remove: true)
                        
                        
                        if searchText.isEmpty {
                            HStack {
                                Text("Now Playing")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                            ZStack {
                                Rectangle()
                                    .fill(Color.clear) // Set the fill color for the rectangle
                                    .frame(width: 285, height: 400)
                                VStack {
                                    SnapCarousel(spacing: 20, trialingSpace: 110, index: $currentIndex, items: viewModel.nowPlaying) { movie in
                                        
                                        KFImage(movie.backdropURL)
                                            .placeholder {
                                                ProgressView()
                                            }
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 285, height: 400)
                                            .cornerRadius(15)
                                            .matchedGeometryEffect(id: movie.id, in: animation)
                                            .onTapGesture {
                                                selectedMovie = movie
                                                showMovieDetail = true
                                                withAnimation(.easeInOut) {
                                                    
                                                    
                                                }
                                            }
                                        
                                    }
                                    .padding(.top, 70)
                                    
                                    CustomIndicator()
                                }
                                
                            }
                            
                            
                            
                            MoviesSectionView(title: "Upcoming", movies: viewModel.upcomings)
                                .transition(.opacity)
                                .animation(.easeInOut, value: viewModel.upcomings)
                            MoviesSectionView(title: "Trending", movies: viewModel.trendings)
                                .transition(.opacity)
                                .animation(.easeInOut, value: viewModel.trendings)
                            MoviesSectionView(title: "Popular", movies: viewModel.populars)
                                .transition(.opacity)
                                .animation(.easeInOut, value: viewModel.populars)
                            MoviesSectionView(title: "Top Rated", movies: viewModel.toprateds)
                                .transition(.opacity)
                                .animation(.easeInOut, value: viewModel.toprateds)
                            
                        } else {
                            SearchResultsView(searchResults: viewModel.searchResults)
                        }
                    }
                    
                }
                .refreshable {
                    refreshData() // Pull to refresh action
                }
            }
            .background(Color.darkNavyBlue)
            // }
        }
        .onAppear {
            
        }
        
        .sheet(isPresented: $showMovieDetail) {
            if let movie = selectedMovie {
                MovieDetailView(model: MovieDetailsViewModel(apiService: APIClient(), movie: movie))
            }
        }
        
    }
    
    // MARK: - SLIDER INDICATOR
    @ViewBuilder
    func CustomIndicator()->some View {
        HStack(spacing: 5) {
            ForEach(viewModel.trendings.indices, id: \.self){index in
                Circle()
                    .fill(currentIndex == index ? .pink : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        } //END HSTACK
        .animation(.easeInOut, value: currentIndex)
    }
    
    private var searchBox: some View {
        HStack {
            TextField("Search movie", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: searchText) { newValue in
                    viewModel.updateSearchText(newValue)
                }
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    viewModel.updateSearchText("")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 16)
            }
        }
    }
    
    private func itemTapped(_ item: Movie) {
        print("Item tapped: \(item)")
    }
    
    private func refreshData() {
        viewModel.loadTrending()
        viewModel.loadPopular()
        viewModel.loadUpcoming()
        viewModel.loadTopRated()
    }
}

#Preview {
    ContentView(viewModel: HomeViewModel(apiService: APITrendingPreviewClient(), persistenceManager: PersistenceManager.shared))
}
