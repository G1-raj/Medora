//
//  MedicationViewExtension.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//

import SwiftUI

extension MedicationsView {
    //appbar
    var header: some View {
        ZStack {
            
            //center title
            Text("My Medications")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
            
            
            //actions
            HStack {
                
                Spacer()
                
                NavigationLink {
                    AddMedicationView()
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
    
    var emptyState: some View {
        VStack {
            
        }
    }
    
    var mainBody: some View {
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
    
    var medicationList: some View {
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
