//
//  CustomButton.swift
//  PhraseMe3D
//
//  Created by Глеб Голощапов on 07.02.2023.
//

import SwiftUI

struct CustomButton: View {
    
    // MARK: - Properties
    let type: CustomButtonType
    let title: String
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(Color("Brown"))
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(type == .white ? .white : .clear)
                .cornerRadius(4)
                .overlay(border())
        }
    }
    
    @ViewBuilder
    private func border() -> some View {
        if type == .transparent {
            RoundedRectangle(cornerRadius: 4)
                .stroke(lineWidth: 1)
                .foregroundColor(Color("Brown"))
        }
    }
}


