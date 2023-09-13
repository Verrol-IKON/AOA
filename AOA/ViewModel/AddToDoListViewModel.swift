//
//  AddToDoListViewModel.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 13/09/23.
//

import Foundation
import Firebase
import SwiftUI

class AddToDoListViewModel: ObservableObject{
    @AppStorage("uid") var userID = ""
    
    @Published var title: String = ""
    @Published var deadline: Date = Date.now
    @Published var category: String = ""
    
    func saveTask(){
        let db = Firestore.firestore()
        db.collection("ToDo").addDocument(data: ["Owner": userID, "Title": title, "Deadline": deadline, "Category": category])
    }    
    
}
