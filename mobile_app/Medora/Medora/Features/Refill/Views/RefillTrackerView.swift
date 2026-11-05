//
//  RefillTrackerView.swift
//  Medora
//
//  Created by Govine Rajput on 05/11/26.
//

import SwiftUI

struct RefillTrackerView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 18) {
                    
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
