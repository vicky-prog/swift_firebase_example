//
//  spalsh_screen.swift
//  swift-firebase (iOS)
//
//  Created by vignesh on 11/02/25.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    @State private var isActive: Bool = false

    var body: some View {
        Group {
            if isActive {
                // Navigate to the main content
                Loginview()
            } else {
                // Splash screen content
                VStack {
                    Image(systemName: "swift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    Text("Welcome to My App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .onAppear {
                    // Simulate a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}



struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
