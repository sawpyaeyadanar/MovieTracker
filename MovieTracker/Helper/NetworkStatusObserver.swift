//
//  NetworkStatusObserver.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 13/1/68 BE.
//

import Foundation
import Combine

class NetworkStatusObserver: ObservableObject {
    @Published var isOffline: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        observeNetworkStatus()
    }
    
    private func observeNetworkStatus() {
        NetworkMonitor.shared.$isConnected
            .sink { [weak self] isConnected in
                self?.isOffline = !isConnected
            }
            .store(in: &subscriptions)
    }
}
