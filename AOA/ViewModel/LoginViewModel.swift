//
//  LoginViewModel.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 11/09/23.
//

import Foundation
import FirebaseAuth
import SwiftUI

class LoginViewModel: ObservableObject{
    @AppStorage("uid") var userID = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error)
                return
            }
            
            if let authResult = authResult {
                print(authResult)
                withAnimation{
                    self.userID = authResult.user.uid
                }
            }
        }
    }
}
