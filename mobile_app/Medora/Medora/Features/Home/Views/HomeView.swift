//
//  HomeView.swift
//  Medora
//
//  Created by Govine Rajput on 02/11/26.
//

import SwiftUI


struct HomeView: View {

    var body: some View {
        TabView {
            
            Tab("Home", systemImage: "house") {
                HomeDashBoardView()
            }
            
            Tab("Medications", systemImage: "pills") {
                MedicationsView()
            }
            
            Tab("Insights", systemImage: "chart.xyaxis.line") {
                InsightsView()
            }
            
            Tab("Profile", systemImage: "person") {
                ProfileView()
            }
            
        }
        .tint(.themeAccent)
    }
}

#Preview {
    HomeView()
}
