//
//  ProfileView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 4/30/23.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var dataViewModel: DataViewModel
    var body: some View {
        VStack {
            Spacer()
            TextField("Name",
                      text: $dataViewModel.profileState.name,
                      prompt: Text("Name").foregroundColor(.blue))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                .onAppear {
                    
                }
                
            TrackPointsView().environmentObject(dataViewModel)
            HStack {
                Button {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    dataViewModel.isLoggedIn = false
                } label: {
                    Text("Sign Out")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .cornerRadius(20)
                Button {
                    dataViewModel.updateProfile()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(20)
            }.padding(.horizontal).padding(.vertical)
        }
    }
}
