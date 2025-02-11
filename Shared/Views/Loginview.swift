//
//  Loginview.swift
//  swift-firebase (iOS)
//
//  Created by vignesh on 11/02/25.
//

import SwiftUI

struct Loginview: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var isCreatingUser: Bool = false
    
    var body: some View {
        Group{
            
            if let firebaseUser = authViewModel.user{
                HomeView(user: firebaseUser, viewModel: authViewModel)
            }else{
        VStack(spacing:20){
            TextField("Email",text:$email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            SecureField("Password",text:$password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action:{
                if isCreatingUser {
                                  authViewModel.createUser(email: email, password: password)
                              } else {
                                  authViewModel.signIn(email: email, password: password)
                              }
            }){
                if authViewModel.isLoading {
                    ProgressView("Please Wait...")
                                      .progressViewStyle(CircularProgressViewStyle())
                }else{
                Text(!isCreatingUser ? "SignIn":"Create User")
                    .frame(maxWidth: .infinity,maxHeight: 0)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
            Button(action: {
                           isCreatingUser.toggle()
                       }) {
                           Text(isCreatingUser ? "Already have an account? Sign In" : "Don't have an account? Create One")
                               .font(.footnote)
                               .foregroundColor(.gray)
                       }
            
            if let errorMessage = authViewModel.errorMessage{
                Text(errorMessage)
            }
        }
        .padding()
        .fullScreenCover(item: $authViewModel.user) { user in
            HomeView(user: user, viewModel: authViewModel)
           
        }
            }
    }
    }
}

struct Loginview_Previews: PreviewProvider {
    static var previews: some View {
        Loginview()
    }
}


struct HomeView: View {
    let user: User
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Welcome, \(user.email)!")
                .font(.headline)
            Button("Sign Out") {
                viewModel.signOut()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
