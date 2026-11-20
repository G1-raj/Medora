//
//  RefillTrackerViewExtension.swift
//  Medora
//
//  Created by Govine Rajput on 05/11/26.
//

import SwiftUI

extension RefillTrackerView {
    
    //app bar
    var header: some View {
        ZStack {
            Text("Refill Tracker")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 36, height: 36)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.white)
    }
    
    var mainBody: some View {
        VStack {
            
            //tab bar
            MedicationSegmentedControl(
                tabs: tabs,
                selectedTab: $selectedTab
            )
        }
    }
    
    
}
