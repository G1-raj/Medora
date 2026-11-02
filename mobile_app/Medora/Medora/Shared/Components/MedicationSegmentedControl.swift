//
//  MedicationSegmentedControl.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//


import SwiftUI

struct MedicationSegmentedControl: View {

    let tabs: [String]
    @Binding var selectedTab: String

    var body: some View {
        HStack(spacing: 0) {

            ForEach(tabs, id: \.self) { tab in

                Button {
                    withAnimation(.spring(
                        response: 0.35,
                        dampingFraction: 0.8
                    )) {
                        selectedTab = tab
                    }
                } label: {

                    Text(tab)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(
                            selectedTab == tab
                            ? .white
                            : Color.primary
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background {

                            if selectedTab == tab {
                                Capsule()
                                    .fill(Color(
                                        red: 0.20,
                                        green: 0.43,
                                        blue: 0.34
                                    ))
                                    .shadow(
                                        color: .black.opacity(0.08),
                                        radius: 4,
                                        y: 2
                                    )
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            Color(
                red: 0.92,
                green: 0.95,
                blue: 0.91
            ),
            in: Capsule()
        )
    }
}


#Preview {
    
    @Previewable @State var selectedTab = "All"

    let tabs = [
        "All",
        "Active",
        "Inactive"
    ]
    MedicationSegmentedControl(
        tabs: tabs,
        selectedTab: $selectedTab
    )
}
