//
//  InsightsViewExtension.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//

import SwiftUI

extension InsightsView {
    
    //app bar
    var header: some View {
        HStack {
            Text("Insights")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.white)
    }
    
    //empty view
    var emptyView: some View {
        VStack {}
    }
    
    var mainBody: some View {
        VStack {
            
            //tab bar
            MedicationSegmentedControl(
                tabs: tabs,
                selectedTab: $selectedTab
            )
            
            dataView
                .padding(.top, 20)
        }
    }
    
    private var dataView: some View {
        VStack(spacing: 18) {
            
            HStack {
                dataCard(
                    label: "Adherence",
                    dataUpdate: "86%",
                    dataChange: "12%",
                )
                
                dataCard(
                    label: "Dose Taken",
                    dataUpdate: "25/29",
                    dataChange: "4 this week",
                    isAdherence: false
                )
            }
            .frame(maxWidth: .infinity)
            
            AdherenceChartView(adherenceRate: 86)
        }
    }
    
    private func dataCard(
        label: String,
        dataUpdate: String,
        dataChange: String,
        isAdherence: Bool = true
    ) -> some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(dataUpdate)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.black)
                
                HStack(spacing: 6) {
                    Image(systemName: "arrow.up")
                        .font(.caption)
                    
                    Text(dataChange)
                        .font(.caption)
                }
                .foregroundStyle(.themeAccent)
                
            }
            
            if isAdherence {
                CirculatProgressIndicator(
                    isInsightView: true
                )
            } else {
                Image(systemName: "chart.bar.fill")
                    .font(.title)
                    .foregroundStyle(.themeAccent)
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.black.opacity(0.04), lineWidth: 1)
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}
