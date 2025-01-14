//
//  CachedAsyncImage.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import Kingfisher
import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?

    var body: some View {
        if let url {
            KFImage(url)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                
        } else {
            Image(.placeholder)
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 340, height: 200)
        }
        
    }
}


#Preview {
    CachedAsyncImage(url: URL(string: "https://loremflickr.com/200/200?random=1")!)
}
