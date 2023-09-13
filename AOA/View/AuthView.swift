//
//  AuthView.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 11/09/23.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
    var body: some View {
        if(currentViewShowing == "login"){
            LoginView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
                .transition(.move(edge: .trailing))
        } else {
            SignUpView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
                .transition(.move(edge: .trailing))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
