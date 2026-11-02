//
//  OnboardingComponent.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct OnboardingComponent: View {
    
    let imageUrl: String
    let headTitle: String
    let subTitle: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .padding(.bottom, 20)
            
            Text(headTitle)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .bold()
                .padding(.bottom, 10)
            
            Text(subTitle)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    OnboardingComponent(
        imageUrl: "medicine_box",
        headTitle: "Never miss \na dose",
        subTitle: "Get timely reminders for all your \nmedications and build a healthier, \nmore consitent routine."
    )
}
