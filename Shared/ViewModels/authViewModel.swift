//
//  authViewModel.swift
//  swift-firebase (iOS)
//
//  Created by vignesh on 11/02/25.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject{
 
    @Published var user:User? = nil
    @Published var errorMessage:String? = nil
    @Published var isLoading:Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func signIn(email:String,password:String){
        setLoading(true)
        FirebaseService.shared.signIn(email: email, password: password)
            .sink(receiveCompletion: { completion in
                
                if case .failure(let error) = completion {
                                   self.errorMessage = error.localizedDescription
                    self.setLoading(false)
                               }
            },
           receiveValue: { user in
                                  self.user = user
                self.setLoading(false)

                              })
            .store(in: &cancellables)
    }
    
    
    func createUser(email:String,password:String){
        setLoading(true)

        FirebaseService.shared.createUser(email: email, password: password)
            .sink(receiveCompletion: { completion in
                self.handleCompletion(completion)
            }, receiveValue: { user in
                print("User creation complete.")
                self.user = user;
                    
                
                self.setLoading(false)

            })
            .store(in: &cancellables)
    }
    
    
    
    func signOut() {
            do {
                try FirebaseService.shared.signOut()
                self.user = nil
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    
    
    private func setLoading(_ loading: Bool) {
            self.isLoading = loading
            if loading {
                self.errorMessage = nil // Clear error when starting a new operation
            }
        }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
          if case .failure(let error) = completion {
              self.errorMessage = "Error: \(error.localizedDescription)"
              self.setLoading(false)
          }
      }
    
}

