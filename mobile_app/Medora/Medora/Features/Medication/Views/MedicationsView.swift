//
//  MedicationsView.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct MedicationsView: View {
    
    @State private var isScreenEmpty: Bool = false
    @State private var myMedications: [Int] = [0, 1, 3, 4, 5]
    @State private var activeMedications: [Int] = [0, 1, 3]
    @State private var inActiveMedications: [Int] = [0]
    
    @State private var selectedTab = "All"

    private let tabs = [
        "All",
        "Active",
        "Inactive"
    ]
    
    var body: some View {
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
    
    
    //appbar
    private var header: some View {
        ZStack {
            
            //center title
            Text("My Medications")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
            
            
            //actions
            HStack {
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .padding(10)
                        .background(.themeAccent)
                        .foregroundStyle(.white)
                        .bold()
                        .clipShape(Circle())
                }
            }
        }
    }
    
    private var emptyState: some View {
        VStack {
            
        }
    }
    
    private var mainBody: some View {
        VStack {
            
            //tab bar
            MedicationSegmentedControl(
                tabs: tabs,
                selectedTab: $selectedTab
            )
            
            //search bar
            SearchField()
            
            //all medications list
            medicationList
        }
    }
    
    private var medicationList: some View {
        VStack {
            switch selectedTab {
            case "All":
                ForEach(myMedications, id: \.self) { medication in
                    MyMedicationCard()
                }
                
            case "Active":
                ForEach(activeMedications, id: \.self) { medication in
                    MyMedicationCard()
                }
                
            case "Inactive":
                ForEach(inActiveMedications, id: \.self) { medication in
                    MyMedicationCard()
                }
                
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    MedicationsView()
}
