//
//  SignIn.swift
//  PhraseMe3D
//
//  Created by Глеб Голощапов on 05.02.2023.
//

import SwiftUI

struct SignUp: View {
    
    @State private var Login = ""
    @State private var Email = ""
    @State private var Password = ""
    @State private var RePassword = ""
    
    @State private var isPresentedSignIn = false
    
    var body: some View {
        
        VStack {
            Spacer()
            Image("Logo")
            Spacer()
            
            VStack(spacing: 20) {
                CustomTextField(placeholderText: "Login", text: $Login)
                CustomTextField(placeholderText: "E-mail", text: $Email)

                CustomTextField(placeholderText: "Password", isSecureField: true, text: $Password)
                CustomTextField(placeholderText: "RePassword", isSecureField: true, text: $RePassword)
                
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 20) {
                CustomButton(type: .white, title: "Sign Up") {
                    // действие по тапу на кнопку
                }
                
                CustomButton(type: .transparent, title: "I already have an account") {
                    // действие по тапу на кнопку
                    isPresentedSignIn.toggle()
                }.fullScreenCover(isPresented: $isPresentedSignIn) {
                    SignIn()
                }
            }
            .padding()
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Yellow"))
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
