//
//  HomeView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 10/09/23.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    @AppStorage("uid") var userID = ""
    
    @State private var isPresented = false
    
    @State private var menu = 0
    
    var body: some View {
        NavigationView {
            VStack{
                Picker("Menu", selection: $menu) {
                    Text("Chat").tag(0)
                    Text("To-Do List").tag(1)
                }
                .pickerStyle(.segmented).padding(.horizontal)
                if menu == 0 {
                    ForEach(viewModel.names.indices,  id: \.self) { name in
                        NavigationLink(destination: ChatView(title: viewModel.names[name], id: viewModel.ids[name])) {
                            Text(viewModel.names[name])
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.foregroundColor(.black)
                        .padding(.vertical)
                        if name != viewModel.names.count {
                            Divider()
                        }
                    }.padding(.horizontal)
                } else {
                    ForEach(viewModel.ToDo,  id: \.self) { task in
                        Text(task.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer()
                Button{
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                        withAnimation{
                            userID = ""
                        }
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                } label: {
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.all)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                        )
                }.padding()
            }.navigationTitle("Hi! " + viewModel.name)
                .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if menu == 1{
                        NavigationLink(destination: AddToDoListView()){
                            Image(systemName: "text.badge.plus")
                                .resizable()
                                    .frame(width: 32.0, height: 32.0)
                                .foregroundColor(.black)
                        }
                    }
                }
            })

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
