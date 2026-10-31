//
//  DoseCard.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct DoseCard: View {
    var body: some View {
        //visual representation of type of medicine
        HStack(spacing: 8) {
            Image("capsule_tablet")
                .resizable()
                .scaledToFit()
                .clipped()
                .padding(10)
                .frame(width: 70, height: 70)
                .background(.red.opacity(0.25))
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 12
                    )
                )
            
            
            VStack(alignment: .leading, spacing: 6) {
                //Tablet name or dose name
                Text("Vitamin D3")
                    .lineLimit(1)
                    .bold()
                    .foregroundStyle(.black)
                
                //no of tablets
                HStack(spacing: 5) {
                    Text("1 tablet")
                        .font(.footnote)
                    
                    Circle()
                        .fill(.gray)
                        .frame(width: 5, height: 5)
                    
                    Text("1000 MG")
                        .font(.footnote)
                }
                
                //dose timing
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                        .font(.footnote)
                    
                    Text("Today,")
                        .font(.footnote)
                    
                    Text("12:30 PM")
                        .font(.footnote)
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "bell.fill")
                    Text("Take")
                }
                .padding(12)
                .background(.themeAccent)
                .foregroundStyle(.white)
                .bold()
                .clipShape(Capsule())
            }
        }
        .padding(15)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.black.opacity(0.04), lineWidth: 1)
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}

#Preview {
    VStack {
        DoseCard()
    }
    .padding(.horizontal, 24)
}
