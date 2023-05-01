//
//  LoginView.swift
//  Group Challenges
//
//  Created by Justin Kilgo on 4/30/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
      

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    @Binding var isLoggedIn: Bool
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            
            TextField("Email",
                      text: $email ,
                      prompt: Text("Email").foregroundColor(.blue)
            )
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)

            HStack {
                Group {
                    if showPassword {
                        TextField("Password", // how to create a secure text field
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                    } else {
                        SecureField("Password", // how to create a secure text field
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                    }
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.red) // how to change image based in a State variable
                }

            }.padding(.horizontal)

            Spacer()

            Button {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error as NSError? {
                        guard let firError = AuthErrorCode.Code(rawValue: error.code) else {
                            print("there was an error logging in but it could not be matched with a firebase code")
                            return
                        }
                        switch firError {
                        case .emailAlreadyInUse:
                            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                if (error == nil) {
                                    isLoggedIn = true
                                } else {
                                    print(error)
                                }
                            }
                        default:
                            print("idk")
                        }
                    }
                }
//                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//                  guard let strongSelf = self else { return }
//                }
            } label: {
                Text("Sign In")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
            .background(
                isSignInButtonDisabled ? // how to add a gradient to a button in SwiftUI if the button is disabled
                LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(isSignInButtonDisabled) // how to disable while some condition is applied
            .padding()
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(isLoggedIn: false)
//    }
//}
