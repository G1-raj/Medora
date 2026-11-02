//
//  MyMedicationCard.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct MyMedicationCard: View {
    
    @State private var showOptions = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        HStack(alignment: .top,spacing: 12) {
            //image
            Image("capsule_tablet")
                .resizable()
                .scaledToFit()
                .clipped()
                .padding(10)
                .frame(width: 70, height: 70)
                .background(.red.opacity(0.25))
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 12
                    )
                )
            
            
            //details section
            VStack(alignment: .leading, spacing: 8) {
                //medicine name
                Text("Metformin")
                    .lineLimit(1)
                    .bold()
                    .foregroundStyle(.black)
                
                //medicine power
                HStack(spacing: 6) {
                    Text("500 MG")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Circle()
                        .fill(.gray)
                        .frame(width: 5, height: 5)
                    
                    Text("Tablet")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                //medicine dose
                HStack(spacing: 6) {
                    
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("1 Tablet, 2 times daily")
                        .lineLimit(1)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                
                //medicine timing
                //TODO: Implement for multiple timing
                Text("8:00 AM")
                    .frame(height: 10)
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(10)
                    .background(.green.opacity(0.25))
                    .clipShape(
                        Capsule()
                    )
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            //leading actions
            VStack(alignment: .trailing,spacing: 18) {
                
                HStack(spacing: 15) {
                    //TODO: Update this to handle active and inactive state
                    Text("Active")
                        .frame(height: 10)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(10)
                        .background(.green.opacity(0.25))
                        .clipShape(
                            Capsule()
                        )
                    
                    Button {
                        showOptions = true
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .foregroundStyle(.gray)
                            .frame(width: 32, height: 32)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
                
                
                Image(systemName: "chevron.right")
                    .bold()
                    .foregroundStyle(.gray)
            }
        }
        .padding(15)
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
        .confirmationDialog(
            "Medication Options",
            isPresented: $showOptions,
            titleVisibility: .visible
        ) {
            Button("Edit Medication") {
                // Navigate to edit screen
            }

            Button("Mark as Inactive") {
                // Update medication status
            }

            Button("Delete Medication", role: .destructive) {
                showDeleteAlert = true
            }

            Button("Cancel", role: .cancel) {}
        }
        .alert("Delete Medication?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}

            Button("Delete", role: .destructive) {
                // Delete medication
            }
        } message: {
            Text("Are you sure you want to delete this medication?")
        }
    }
}

#Preview {
    MyMedicationCard()
        .padding(.horizontal, 24)
}
