//
//  LogIn.swift
//  Books
//
//  Created by dennis savchenko on 01/10/2024.
//

import SwiftUI

struct LogIn: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(title: "Email", text: $email, example: "").tint(.gray)
                CustomSecureField(title: "Password", text: $password, logIn: true)
            }
            .navigationTitle("Log In")
            .padding()
        }
    }
}

#Preview {
    LogIn()
}
