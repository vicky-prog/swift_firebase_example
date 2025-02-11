//
//  firebase_service.swift
//  swift-firebase (iOS)
//
//  Created by vignesh on 11/02/25.
//

import Foundation
import FirebaseAuth
import Combine


final class FirebaseService{
    static let shared = FirebaseService()
    private let auth = Auth.auth()
    
    func signIn(email:String,password:String) -> Future<User,Error>{
        return Future{ promise in
            self.auth.signIn(withEmail: email, password: password){ result, error in
                if let error = error{
                    promise(.failure(error))
                }else if let user = result?.user{
                    let userModel = User(id: user.uid, email: user.email ?? "", displayName: user.displayName ?? "");
                    promise(.success(userModel))
                }
                
            }
            
        }
    }
    
    func createUser(email:String,password:String) -> Future<User,Error>{
        return Future{ promise in
            self.auth.createUser(withEmail: email, password: password){result,error in
                print(result as Any)
                if let error = error{
                    promise(.failure(error))
                } else if let user = result?.user {
                    let userModel = User(id: user.uid, email: user.email ?? "", displayName: user.displayName ?? "");
                    promise(.success(userModel))
                }
                
            }
            
        }
    }
    
    func signOut() throws{
       try auth.signOut();
    }
    
}
