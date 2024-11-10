//
//  CustomeSecureField.swift
//  Foreo
//
//  Created by dennis savchenko on 14/09/2024.
//

import SwiftUI

struct CustomSecureField: View {
    
    enum FocusedField {
        case visible, invisible
    }
    
    var title: LocalizedStringKey
    @Binding var text: String
    var hint: LocalizedStringKey? = nil
    @FocusState private var focused: FocusedField?
    @State private var isSecure: Bool = true
    @State private var showsError: Bool = false
    @State var logIn: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontDesign(.serif)
                .fontWeight(focused != nil ? .semibold : nil)
                HStack {
                    ZStack {
                        SecureField(hint ?? "", text: $text)
                            .frame(height: 22)
                            .focused($focused, equals: .invisible)
                            .opacity(isSecure ? 1 : 0)
                        TextField(hint ?? "", text: $text)
                            .autocorrectionDisabled()
                            .focused($focused, equals: .visible)
                            .opacity(isSecure ? 0 : 1)
                    }
                    Button {
                        isSecure.toggle()
                        focused = focused == .invisible ? .visible : .invisible
                    } label: {
                        Image(systemName: isSecure ? "eye" : "eye.slash")
                    }
                }
                .padding()
                .tint(.gray)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(focused != nil ? .black : showsError && !logIn ? .error : Color(.systemGray2), lineWidth: focused != nil ? 2 : 1)
                }
            if !logIn {
                Text("Minimum 6 characters, include a number, a special character, an uppercase and a lowercase letter.")
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(showsError ? .error : .gray)
                    .fontWeight(.medium)
                    .font(.footnote)
            }
        }
        .onChange(of: focused) {
            if focused == nil {
               showsError = !isValidPassword(text)
            }
        }
    }

    func isValidPassword(_ password: String) -> Bool {
        
        guard password.count >= 6 else { return false }
        
        let uppercaseLetterRegEx = ".*[A-Z]+.*"
        let lowercaseLetterRegEx = ".*[a-z]+.*"
        let digitRegEx = ".*[0-9]+.*"
        let specialCharacterRegEx = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        
        let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegEx)
        guard uppercaseLetterTest.evaluate(with: password) else { return false }
        
        let lowercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegEx)
        guard lowercaseLetterTest.evaluate(with: password) else { return false }
        
        let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegEx)
        guard digitTest.evaluate(with: password) else { return false }
        
        let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        guard specialCharacterTest.evaluate(with: password) else { return false }
        
        return true
        
    }
    
}

#Preview {
    CustomSecureField(title: "Password", text: .constant(""), logIn: false)
}
