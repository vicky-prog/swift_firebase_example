//
//  HomeView.swift
//  swift-firebase (iOS)
//
//  Created by vignesh on 18/02/25.
//

import SwiftUI

struct HomeView: View {
    let user: User
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        TabView {
            // Home Tab
            VStack {
                Text("Welcome, \(user.email)!")
                    .font(.headline)
               
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // Search Tab (placeholder content)
            VStack {
                Text("Search")
                    .font(.headline)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }

            // Profile Tab (placeholder content)
            VStack {
                Text("Profile")
                    .font(.headline)
                Button("Sign Out") {
                    viewModel.signOut()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .accentColor(.blue)  // Customize selected tab color
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: User(id: "", email: "test@example.com", displayName: "John Doe"), viewModel: AuthViewModel())
    }
}
