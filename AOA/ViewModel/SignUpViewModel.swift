//
//  SignUpViewModel.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 11/09/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class SignUpViewModel: ObservableObject{
    @AppStorage("uid") var userID = ""
    
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    
    func signUp(){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

            if let error = error{
                print(error)
                return
            }

            if let authResult = authResult{
                print(authResult)
                withAnimation{
                    self.userID = authResult.user.uid
                    self.makeUser(uid: self.userID, name: self.name)
                }
            }
        }
    }
    
    func makeUser(uid: String, name: String){
        let db = Firestore.firestore()
        db.collection("Users").document(uid).setData(["Name": name]) 
    }
}
