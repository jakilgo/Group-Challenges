//
//  Group_ChallengesApp.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 4/30/23.
//

import SwiftUI

@main
struct Group_ChallengesApp: App {
    var body: some Scene {
        WindowGroup {
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
        }
    }
}
