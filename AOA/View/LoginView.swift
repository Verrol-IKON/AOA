//
//  LoginView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 10/09/23.
//

import SwiftUI

struct LoginView: View {
    @Binding var currentShowingView: String
    
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0){
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                }.padding().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                ).padding()
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                    if(password.count != 0){
                        if(password.count >= 8){
                            Image(systemName: "checkmark")
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                    }
                }.padding().overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                ).padding()
                Button(action: {
                    withAnimation{
                        self.currentShowingView = "signup"
                    }
                    
                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                Spacer()
                Spacer()
                Button{
                    if(email.count != 0 && email.isValidEmail() == true){
                        if(password.count != 0 && password.count >= 8){
                            viewModel.email = email
                            viewModel.password = password
                            viewModel.login()
                        }
                    }
                } label: {
                    Text("Sign In")
                        .foregroundColor(email.count == 0 || email.isValidEmail() == false || password.count < 8 ? .gray : .white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .padding(.horizontal)
                        )
                }.disabled(email.count == 0 || email.isValidEmail() == false || password.count < 8)
            }.navigationTitle("Sign In")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentShowingView: .constant(""))
    }
}
