//
//  ContentView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 10/09/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("uid") var userID = ""
    
    var body: some View {
        
        if userID == "" {
            AuthView()
        } else {
            HomeView()
                .transition(.move(edge: .bottom))
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
