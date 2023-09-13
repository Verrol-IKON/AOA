//
//  SignUpView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 11/09/23.
//

import SwiftUI

struct SignUpView: View {
    @Binding var currentShowingView: String
    
    @StateObject private var viewModel: SignUpViewModel = SignUpViewModel()
    
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var conPassword: String = ""
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
                    Image(systemName: "person")
                    TextField("Name", text: $name)
                    
                    Spacer()
                    if (name.count != 0){
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
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
                HStack{
                    Image(systemName: "lock")
                    SecureField("Confirm Password", text: $conPassword)
                    
                    Spacer()
                    
                    if(conPassword.count != 0){
                        if(conPassword == password){
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
                        self.currentShowingView = "login"
                    }
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                Spacer()
                Spacer()
                Button{
                    if(email.count != 0 && email.isValidEmail() == true){
                        if (name.count != 0){
                            if(password.count != 0 && password.count >= 8){
                                if(conPassword.count != 0 && conPassword == password){
                                    viewModel.email = email
                                    viewModel.name = name
                                    viewModel.password = password
                                    viewModel.signUp()
                                }
                            }
                        }
                    }
                } label: {
                    Text("Sign Up")
                        .foregroundColor(email.count == 0 || email.isValidEmail() == false || name.count == 0 || password.count < 8 || conPassword.count == 0 || conPassword != password ? .gray : .white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .padding(.horizontal)
                        )
                }.disabled(email.count == 0 || email.isValidEmail() == false || name.count == 0 || password.count < 8 || conPassword.count == 0 || conPassword != password)
            }.navigationTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(currentShowingView: .constant(""))
    }
}
