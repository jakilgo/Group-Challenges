//
//  AddDataView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 5/1/23.
//

import SwiftUI

var i = 0

struct TrackPointsView: View {
    @EnvironmentObject var dataViewModel: DataViewModel
    @State var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<dataViewModel.profileState.days.count, id: \.self) { number in
                LazyHStack(alignment: .center) {
                    TrackPointsFormView()
                        .environmentObject(dataViewModel.profileState.days[number])
                }.tag(number)
            }
        }.tabViewStyle(.page(indexDisplayMode: .never))
    }
}

