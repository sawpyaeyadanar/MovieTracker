//
//  MovieTrackerApp.swift
//  MovieTracker
//
//  Created by Saw Pyae Yadanar on 12/1/68 BE.
//

import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    

    return true
  }
}

@main
struct MovieTrackerApp: App {
    let persistenceManager = PersistenceManager.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
                ContentView(viewModel: HomeViewModel(apiService: APIClient(), persistenceManager: persistenceManager))
                    .environment(\.managedObjectContext, persistenceManager.container.viewContext)
            }
    }
}
