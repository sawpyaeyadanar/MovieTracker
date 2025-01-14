//
//  CastView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 22/8/23.
//

import Kingfisher
import SwiftUI

struct CastView: View {
    let cast: CastProfile
    
    var body: some View {
        VStack {
            CachedAsyncImage(url: cast.photoURL)
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            Text(cast.name)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .frame(width: 100)
                .lineLimit(2)
        }
    }
}

#Preview {
    CastView(cast: CastProfile(id: 1, name: "Heart Stone", profile_path: "https://image.tmdb.org/t/p/w200/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg"))
}
