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
    @State var selectedTab = "Fourth"
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(nums, id: \.self) { number in
                LazyVStack(alignment: .center) {
                    Text(number)
                }.tag(nums)
            }
        }.tabViewStyle(.page(indexDisplayMode: .never))
    }
}

var nums = ["First", "Second", "Third", "Fourth"]
