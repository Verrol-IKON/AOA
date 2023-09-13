//
//  HomeViewModel.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 12/09/23.
//

import Foundation
import Firebase
import SwiftUI

class HomeViewModel: ObservableObject{
    
    @AppStorage("uid") var userID = ""
    
    @Published var name: String = ""
    
    @Published var names: [String] = []
    @Published var ids: [String] = []
    
    @Published var ToDo: [Task] = []
    
    let db = Firestore.firestore()
    
    init(){
        getUserName()
        getUsers()
        getToDoList()
    }
    
    func getUserName(){
        let docRef = db.collection("Users").document(userID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.name = document.get("Name") as! String
                print("Document exist")
            } else {
                
                print("Document does not exist")
            }
        }
    }
    
    func getUsers(){
        db.collection("Users").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    if document.documentID != self.userID {
                        self.names.append(document.get("Name") as! String)
                        self.ids.append(document.documentID)
                    }
                }
            }
        }
    }
    
    func getToDoList(){
        db.collection("ToDo").whereField("Owner", isEqualTo: self.userID).getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    self.ToDo.append(Task(ownerId: document.get("Owner"), title: document.get("Title"), deadline: document.get("Deadline"), category: document.get("Category")))
                }
            }
        }
    }
}
