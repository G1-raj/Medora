//
//  MedicationDetailViewExtension.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//

import SwiftUI

extension MedicationDetailView {
    
    //appbar
    var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(width: 36, height: 36)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)

            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(width: 36, height: 36)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.white)
    }
    
    //image section
    var imageSection: some View {
        Image("capsule_tablet")
            .resizable()
            .scaledToFit()
            .padding(35)
            .frame(width: 120, height: 120)
            .background(Color.red.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .frame(maxWidth: .infinity)
            .padding(.bottom, 4)
    }
    
    //medication info section
    var medicationInfo: some View {
        
        //name and active section
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Metformin")
                        .font(.title)
                        .foregroundStyle(.black)
                        .bold()
                    
                    HStack(spacing: 8) {
                        Text("500 mg")
                            .foregroundStyle(.gray)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 5, height: 5)
                        
                        Text("Tablet")
                            .foregroundStyle(.gray)
                    }
                }
                
                Spacer()
                
                Text("Active")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(.green.opacity(0.15))
                    .clipShape(Capsule())
            }
            
            //dose detail section
            HStack(spacing: 18) {
                Image(systemName: "clock")
                    .foregroundStyle(.gray)
                
                Text("1 tablet, 2 times daily")
                    .foregroundStyle(.gray)
            }
            
            //dose timing section
            HStack(spacing: 18) {
                Text("8:00 AM")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(.gray.opacity(0.15))
                    .clipShape(Capsule())
                
                
                Text("8:00 PM")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(.gray.opacity(0.15))
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var adherenceSection: some View {
        VStack {
            AdherenceChartView(adherenceRate: 86)
        }
    }
    
    var actions: some View {
        VStack(spacing: 12) {
            actionButton(
                icon: "calendar",
                label: "Refill Reminder",
                subLabel: "In 12 days",
                onTap: {}
            )
            
            actionButton(
                icon: "clock",
                label: "View History",
                subLabel: "See your medication log",
                onTap: {}
            )
            
            actionButton(
                icon: "note.text",
                label: "Notes",
                subLabel: "Add personal notes",
                onTap: {}
            )
        }
    }

    
    private func actionButton(
        icon: String,
        label: String,
        subLabel: String,
        onTap: @escaping () -> Void
    ) -> some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 12) {
                
                Image(systemName: icon)
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .foregroundStyle(.themeAccent)
                    .bold()
                    .background(.themeAccent.opacity(0.15))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(label)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.black)
                    
                    Text(subLabel)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
    }

}
