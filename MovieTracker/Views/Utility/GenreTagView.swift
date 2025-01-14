//
//  GenreTagView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import SwiftUI

struct GenreTagView: View {
    let genre: String
    
    var body: some View {
        Text(genre)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray)
            .cornerRadius(10)
    }
}

#Preview {
    GenreTagView(genre: "Comedy")
}
