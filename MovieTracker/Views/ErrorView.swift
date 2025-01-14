//
//  ErrorView.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    ErrorView(errorMessage: "error")
}
