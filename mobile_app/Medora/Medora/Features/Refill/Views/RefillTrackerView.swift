//
//  RefillTrackerView.swift
//  Medora
//
//  Created by Govine Rajput on 05/11/26.
//

import SwiftUI

struct RefillTrackerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var selectedTab = "All"
    
    let tabs = [
        "All",
        "Low",
        "Refill Soon",
        "Overdue"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            header
            
            ScrollView {
                VStack(spacing: 18) {
                    mainBody
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                .padding(.bottom, 24)
                .frame(maxWidth: 500)
                .frame(maxWidth: .infinity)
            }
            .background(.white)
            .scrollDismissesKeyboard(.interactively)
            .background(Color(.systemGroupedBackground))
        }
        .background(.white)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RefillTrackerView()
}
