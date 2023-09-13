//
//  UserDetailsView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 13/09/23.
//

import SwiftUI

struct ChatView: View {
    
    @AppStorage("uid") var userID = ""
    
    @StateObject private var viewModel: ChatViewModel = ChatViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var title: String
    var id: String
    
    @State private var chat: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(viewModel.messages, id: \.self){ message in
                            HStack{
                                if message.user1Id == self.userID && message.user2Id == self.id{
                                    Spacer()
                                    Text(message.text)
                                        .font(.title2)
                                        .padding(5)
                                        .foregroundColor(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.black)
                                        ).padding()
                                } else if message.user1Id == self.id && message.user2Id == self.userID{
                                    Text(message.text)
                                        .font(.title2)
                                        .padding(5)
                                        .background(.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding()
                                    Spacer()
                                }
                            }.onAppear{
                                scrollProxy.scrollTo(viewModel.messages.last!)
                            }
                        }
                    }
                }
                Spacer()
                HStack{
                    TextField("Type message here...", text: $chat, axis: .vertical)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.black)
                        )
                    Spacer()
                    Button{
                        viewModel.message = chat
                        viewModel.user1Id = self.userID
                        viewModel.user2Id = self.id
                        viewModel.sendMessage()
                        chat = ""
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }.padding()
            }.onAppear(perform: viewModel.loadMessages)
        }.navigationBarTitle(title, displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Home") {
                        presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.black)
                }
            })
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(title: "", id: "")
    }
}
