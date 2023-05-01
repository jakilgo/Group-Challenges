//
//  ProfileView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 4/30/23.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var dataViewModel: DataViewModel
    var body: some View {
        VStack {
            Spacer()
            TextField("Name",
                      text: $dataViewModel.state.name,
                      prompt: Text("Name").foregroundColor(.blue))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                .onAppear {
                    
                }
                
            Spacer()
            HStack {
                Button {
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    isLoggedIn = false
                } label: {
                    Text("Sign Out")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
                    .background(.red)
                    .cornerRadius(20)
                Button {
//                    dataViewModel.state.points += 1
                    dataViewModel.updateProfile()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
                    .background(.blue)
                    .cornerRadius(20)
            }.padding(.horizontal).padding(.vertical)
        }
    }
}
