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
    private var cancellables = Set<AnyCancellable>()
    
    func signIn(email:String,password:String){
        FirebaseService.shared.sigIn(email: email, password: password)
            .sink(receiveCompletion: { completion in
                
                if case .failure(let error) = completion {
                                   self.errorMessage = error.localizedDescription
                               }
            },
           receiveValue: { user in
                                  self.user = user
                              })
            .store(in: &cancellables)
    }
    
    
    func createUser(email:String,password:String){
        FirebaseService.shared.createUSer(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion{
                    self.errorMessage = error.localizedDescription
                }
                
            }, receiveValue: { user in
                print("User creation complete.")
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
    
}

