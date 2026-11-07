//
//  InsightsView.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//

import SwiftUI

struct InsightsView: View {
    
    @State var isEmpty: Bool = false
    
    @State var selectedTab = "Week"

    let tabs = [
        "Week",
        "Month",
        "Quarter",
        "Year"
    ]
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            header
            
            ScrollView {
                VStack(spacing: 18) {
                    if isEmpty {
                        emptyView
                    } else {
                        mainBody
                    }
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
    InsightsView()
}
