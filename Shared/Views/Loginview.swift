//
//  Loginview.swift
//  swift-firebase (iOS)
//
//  Created by vignesh on 11/02/25.
//

import SwiftUI
import CoreData

struct Loginview: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var isCreatingUser: Bool = false
    
    fileprivate func loginAction() {
        if isCreatingUser {
            authViewModel.createUser(email: email, password: password)
        } else {
            authViewModel.signIn(email: email, password: password)
        }
    }
    
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
                loginAction()
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


//struct HomeView: View {
//    let user: User
//    @ObservedObject var viewModel: AuthViewModel
////    @Environment(\.managedObjectContext) private var viewContext
////       @FetchRequest(
////           entity: Task.entity(),
////           sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)]
////       )
//    //private var tasks: FetchedResults<MyTask>
//    
//    var body: some View {
//        VStack {
//            Text("Welcome, \(user.email)!")
//                .font(.headline)
//            Button("Sign Out") {
//                viewModel.signOut()
//            }
//            .padding()
//            .background(Color.red)
//            .foregroundColor(.white)
//            .cornerRadius(8)
////
////            List {
////                           ForEach(tasks) { task in
////                               VStack(alignment: .leading) {
////                                   Text(task.task).font(.headline)
////                                   //Text("Age: \(user.age)").font(.subheadline)
////                               }
////                           }
////                       }
////                       Button("Add User") {
////                           addTask(name: "Task One", context: viewContext)
////                       }
//        }
//    }
//    
////    func addTask(name: String,  context: NSManagedObjectContext) {
////           let newTask = Task(context: context)
////           newTask.id = UUID()
////           newTask.task = name
////           newTask.createdAt = Date()
////
////           do {
////               try context.save()
////           } catch {
////               print("Failed to save task: \(error)")
////           }
////       }
//}
