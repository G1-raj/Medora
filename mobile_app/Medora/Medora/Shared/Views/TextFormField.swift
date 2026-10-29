//
//  TextFormField.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct TextFormField: View {
    
    let label: String
    let hintText: String
    var fieldType: FieldType = .email
    
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false
    
    enum FieldType {
        case email
        case username
        case password
        
        var icon: String {
            switch self {
            case .email:
                return "envelope"
                
            case .username:
                return "person"
                
            case .password:
                return "lock"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title3)
                .foregroundStyle(.black)
            
            HStack(spacing: 10) {
                       
               Image(systemName: fieldType.icon)
                   .foregroundStyle(.gray)
               
               Group {
                   if fieldType == .password && !isPasswordVisible {
                       SecureField(hintText, text: $text)
                   } else {
                       TextField(hintText, text: $text)
                           .textInputAutocapitalization(
                               fieldType == .email ? .never : .sentences
                           )
                           .autocorrectionDisabled(
                               fieldType == .email || fieldType == .username
                           )
                           .keyboardType(
                               fieldType == .email ? .emailAddress : .default
                           )
                   }
               }
               
               if fieldType == .password {
                   Button {
                       isPasswordVisible.toggle()
                   } label: {
                       Image(
                           systemName: isPasswordVisible
                               ? "eye"
                               : "eye.slash"
                       )
                       .foregroundStyle(.gray)
                   }
                   .buttonStyle(.plain)
               }
               
           }
           .padding()
           .background(.white)
           .overlay {
               RoundedRectangle(cornerRadius: 15)
                   .stroke(.gray, lineWidth: 1)
           }
        }
        .frame(maxWidth: .infinity)
//        .padding(.horizontal, 20)
    }
}

#Preview {
    @Previewable @State var email = ""
    
    TextFormField(
        label: "Email",
        hintText: "Email",
        fieldType: .email,
        text: $email
    )
}
