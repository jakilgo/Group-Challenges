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
    @StateObject var dataVM = DataViewModel()
//    @State var selectedTab = 1
    var body: some Scene {
        WindowGroup {
            if (dataVM.isLoggedIn) {
                TabView {
                    LeaderboardView()
                        .tabItem {
                            Label("Leaderboard", systemImage: "medal")
                        }.tag(1)
                        .environmentObject(dataVM)
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }.tag(2)
                        .environmentObject(dataVM)
                }   .onAppear { dataVM.createListeners() }
                    .onDisappear { dataVM.removeListeners(); print("cool") }
            } else {
                LoginView()
                    .environmentObject(dataVM)
            }
        }
    }
}
