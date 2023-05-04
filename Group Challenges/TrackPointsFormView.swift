//
//  TrackPointsFormView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 5/1/23.
//

import SwiftUI

struct TrackPointsFormView: View {
    @EnvironmentObject var currDay: DailyData
    let options = ["0", "1", "2"]
    @State var selectionBonus: String
    @State var selectionMed: String
    @State var selectionShort: String
    @State var minWater: Bool
    var body: some View {
        VStack(alignment: .center) {
            Text(currDay.date).font(.title).bold()
            Spacer()
            HStack(alignment: .center) {
                Text("Steps: ").font(.title3)
                TextField("Steps",
                          value: $currDay.steps,
                          format: .number)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                .keyboardType(.numberPad)
            }
            HStack(alignment: .center) {
                Text("Bonus Exercise: ").font(.title3)
                VStack {
                    Picker("Bonus Exercise", selection: $selectionBonus) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .onReceive([self.selectionBonus].publisher.first()) { value in
                        currDay.bonusExercise = Int(value)!
                    }
                }
            }
            HStack(alignment: .center) {
                Text("Medium Exercise: ").font(.title3)
                VStack {
                    Picker("Medium Exercise", selection: $selectionMed) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .onReceive([self.selectionMed].publisher.first()) { value in
                        currDay.medExercise = Int(value)!
                    }
                }
            }
            HStack(alignment: .center) {
                Text("Short Exercise: ").font(.title3)
                VStack {
                    Picker("Short Exercise", selection: $selectionShort) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .onReceive([self.selectionShort].publisher.first()) { value in
                        currDay.shortExercise = Int(value)!
                    }
                }
            }
            Toggle(isOn: $minWater) {
                Text("Minimum Water?")
            }
            .toggleStyle(iOSCheckboxToggleStyle())
            .onReceive([self.minWater].publisher.first()) { value in
                currDay.minWater = value
            }
            Spacer()
        }
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                configuration.label
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
            }
        })
    }
}
