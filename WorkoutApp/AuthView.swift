//
//  AuthView.swift
//  WorkoutApp
//
//  Created by Cameron Crockett on 11/26/24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var authModel: AuthModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var navigateToContentView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("FitTrack")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .underline()
                    .padding(.top)
                
                Spacer()
                
                Text(isSignUp ? "Register" : "Sign In")
                    .font(.title2)
                    .bold()
                    .italic()
                    .padding()
                    
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if authModel.errorMessage != nil {
                    Text(authModel.errorMessage!)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    if isSignUp {
                        authModel.registerUser(email: email, password: password)
                    } else {
                        signInAndNavigate()
                    }
                }) {
                    Text(isSignUp ? "Sign Up" : "Sign In")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 2)
                        )
                }
                
                Spacer()
                NavigationLink(destination: ContentView().environmentObject(authModel), isActive: $navigateToContentView) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
        }
    }

    private func signInAndNavigate() {
        authModel.signInUser(email: email, password: password)
        if authModel.isUserAuthenticated {
            navigateToContentView = true
        }
    }
}



