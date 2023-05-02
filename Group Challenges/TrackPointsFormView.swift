//
//  TrackPointsFormView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 5/1/23.
//

import SwiftUI

struct TrackPointsFormView: View {
    @EnvironmentObject var currDay: DailyData
    var body: some View {
        Text(currDay.getPrint())
    }
}
