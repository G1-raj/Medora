//
//  HomeDashBoardView.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct HomeDashBoardView: View {
    
    
    @State private var isScreenEmpty: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                
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
            .background(alignment: .topTrailing) {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 250, height: 250)
                    .ignoresSafeArea()
            }
        }
    }
    
    
    private var emptyState: some View {
        VStack {}
    }
    
    private var mainBody: some View {
        VStack(alignment: .leading, spacing: 8) {
            calender
            
            DayProgressCard(
                noOfDosesTaken: 2,
                totalNoOfDoses: 3
            )
            .padding(.bottom, 20)
            
            nextDose
                .padding(.bottom, 20)
            
            todaysMedication
                .padding(.bottom, 20)
            
            insightButtons
        }
    }
    
    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                //greeting
                Text("Good Morning")
                    .foregroundStyle(.themeAccent)
                
                //user first name
                Text("Govind")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.themeAccent)
                
                //headline
                Text("Stay consistent, stay healthy.")
                    .foregroundStyle(.themeAccent)
            }
            
            Spacer()
            
            Button {
                //TODO: Add the notifications page route
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 22))
                    .foregroundStyle(.themeAccent)
                    .bold()
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .clipShape(Circle())
            }
        }
    }
    
    private var calender: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(.black.opacity(0.15))
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
    }
    
    private var nextDose: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Next Dose")
                    .bold()
                    .foregroundStyle(.black)
                
                Spacer()
                
                //navigate to see all the doses
                TextButton(text: "See All") {
                    
                }
            }
            
            //card to show next dose
            DoseCard()
        }
    }
    
    private var todaysMedication: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Today's Medications")
                    .bold()
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text("3 total")
                    .foregroundStyle(.gray)
            }
            
            //card to show today's all medication
            DayMedicationCard()
            
        }

    }
    
    private var insightButtons: some View {
        HStack(spacing: 12) {
            insightButton(
                icon: "calendar",
                label: "Refill Reminders",
                subLabel: "2 medications",
                onTap: {}
            )

            insightButton(
                icon: "chart.bar.fill",
                label: "Health Insights",
                subLabel: "View your progress",
                onTap: {}
            )
        }
    }
    
    private func insightButton(
        icon: String,
        label: String,
        subLabel: String,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(action: onTap) {
            HStack(spacing: 10) {

                // Icon
                Image(systemName: icon)
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(.themeAccent)
                    .frame(width: 44, height: 44)
                    .background(.themeAccent.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                // Text details
                VStack(alignment: .leading, spacing: 5) {
                    Text(label)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text(subLabel)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }

                Spacer(minLength: 0)

                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.gray.opacity(0.7))
            }
            .padding(12)
            .frame(maxWidth: .infinity, minHeight: 76)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black.opacity(0.05), lineWidth: 1)
            }
            .shadow(
                color: .black.opacity(0.05),
                radius: 8,
                x: 0,
                y: 3
            )
            .contentShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }}

#Preview {
    HomeDashBoardView()
}
