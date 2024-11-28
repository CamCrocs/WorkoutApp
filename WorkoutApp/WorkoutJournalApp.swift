//
//  WorkoutAppApp.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/25/24.
//

import SwiftUI
import FirebaseCore
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WorkoutJournalApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authModel = AuthModel()


  var body: some Scene {
    WindowGroup {
        Group {
            if authModel.isUserAuthenticated {
                ContentView()
                    .environmentObject(authModel)
            } else {
                AuthView()
                    .environmentObject(authModel)
            }
        }
        .animation(.easeInOut, value: authModel.isUserAuthenticated)
    }
  }
}
