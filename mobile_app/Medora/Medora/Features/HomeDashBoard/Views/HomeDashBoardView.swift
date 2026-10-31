//
//  HomeDashBoardView.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct HomeDashBoardView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        calender
                        
                        DayProgressCard(
                            noOfDosesTaken: 2,
                            totalNoOfDoses: 3
                        )
                        .padding(.bottom, 20)
                        
                        nextDose
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
}

#Preview {
    HomeDashBoardView()
}
