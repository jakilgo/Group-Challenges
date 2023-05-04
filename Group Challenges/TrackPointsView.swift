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
                    TrackPointsFormView(selectionBonus: String(dataViewModel.profileState.days[number].bonusExercise),
                                        selectionMed: String(dataViewModel.profileState.days[number].medExercise),
                                        selectionShort: String(dataViewModel.profileState.days[number].shortExercise),
                                        minWater: dataViewModel.profileState.days[number].minWater)
                        .environmentObject(dataViewModel.profileState.days[number])
                }.tag(number)
            }
        }.tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear { selectedTab = dataViewModel.profileState.days.count-1 }
    }
}

