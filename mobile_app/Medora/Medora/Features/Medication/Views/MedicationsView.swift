//
//  MedicationsView.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct MedicationsView: View {
    
    @State var isScreenEmpty: Bool = false
    @State var myMedications: [Int] = [0, 1, 3, 4, 5]
    @State var activeMedications: [Int] = [0, 1, 3]
    @State var inActiveMedications: [Int] = [0]
    
    @State var selectedTab = "All"

    let tabs = [
        "All",
        "Active",
        "Inactive"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                header
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        if isScreenEmpty {
                            emptyState
                        } else {
                            mainBody
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                    .frame(maxWidth: 500)
                    .frame(maxWidth: .infinity)
                }
                .scrollDismissesKeyboard(.interactively)
                .background(.background)
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

#Preview {
    MedicationsView()
}
