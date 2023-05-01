//
//  Group_ChallengesApp.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 4/30/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions                    launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Group_ChallengesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var isLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            if (isLoggedIn) {
                TabView {
                    LeaderboardView()
                        .tabItem {
                            Label("Leaderboard", systemImage: "medal")
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }
                }
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .onAppear { isLoggedIn = (Auth.auth().currentUser?.uid != nil) }
            }
        }
    }
}
