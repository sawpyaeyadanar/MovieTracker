//
//  VideoPlayerView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//
import AVKit
import SwiftUI

struct VideoPlayerView: View {
  
    var body: some View {
        VStack {
            if let player = playVideo(fileName: "localvideo", fileFormat: "mp4") {
                VideoPlayer(player: player)
                    .overlay(alignment: .topLeading) {
                        Image(systemName: "play")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .padding(.top, 6)
                            .padding(.horizontal, 8)
                    }
            }
                
            
            
        } //: VSTACK
        .accentColor(.accentColor)
        .navigationBarTitle("Trailer", displayMode: .inline)
    }
}

#Preview {
    VideoPlayerView()
}
