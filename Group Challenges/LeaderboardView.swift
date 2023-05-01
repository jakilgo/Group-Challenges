//
//  LeaderboardView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 4/30/23.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var dataViewModel: DataViewModel
    var body: some View {
        NavigationView {
            List(dataViewModel.listState) { player in
                HStack(alignment: .top) {
                    Text(player.name)
                        .font(.title)
                    Spacer()
                    Text(String(player.points))
                        .font(.title)
                        .foregroundColor(.gray)
                }.listRowBackground(player.name == dataViewModel.profileState.name ? Color.blue.opacity(0.1) : Color.white)
            }.listStyle(.inset)
        }
        
    }
}
