//
//  ChatViewModel.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 13/09/23.
//

import Foundation
import FirebaseDatabase
import Firebase

class ChatViewModel: ObservableObject{
    
    @Published var message: String = ""
    @Published var user1Id: String = ""
    @Published var user2Id: String = ""
    
    @Published var messages: [Message] = []
    
    func sendMessage(){
        guard !message.isEmpty else {return}
        let dbRef = Database.database().reference()
        let messageRef = dbRef.child("messages").childByAutoId()
        let messageData = ["text": message, "user1Id": user1Id, "user2Id": user2Id]
        messageRef.setValue(messageData)
    }
    
    func loadMessages(){
        let dbref = Database.database().reference()
        dbref.child("messages").observe(.childAdded){snapshot in
            if let data = snapshot.value as? [String: Any],
               let text = data["text"] as? String,
               let user1Id = data["user1Id"] as? String,
               let user2Id = data["user2Id"] as? String{
                self.messages.append(Message(text: text, user1Id: user1Id, user2Id: user2Id))
            }
        }
    }
    
}
