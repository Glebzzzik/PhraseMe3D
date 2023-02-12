//
//  SignIn.swift
//  PhraseMe3D
//
//  Created by Глеб Голощапов on 05.02.2023.
//

import SwiftUI

struct SignIn: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isPresentedSignUp = false
    
    var body: some View {
        
        VStack {
            Spacer()
            Image("Logo")
            Spacer()
            
            VStack(spacing: 20) {
                CustomTextField(placeholderText: "E-mail", text: $email)
                CustomTextField(placeholderText: "Password", isSecureField: true, text: $password)
                
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 20) {
                CustomButton(
                    model: CustomButton.Model(
                        type: .white,
                        title: "Sign In"
                    )
                ) {
                    // действие по тапу на кнопку
                }
                
                CustomButton(
                    model: CustomButton.Model(
                        type: .transparent,
                        title: "Sign Up"
                    )
                ) {
                    isPresentedSignUp = true
                }
                .fullScreenCover(isPresented: $isPresentedSignUp) {
                    SignUp()
                }
            }
            .padding()
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Yellow"))
    }
}


struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
