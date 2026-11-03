//
//  AddMedicatonView.swift
//  Medora
//
//  Created by Govine Rajput on 03/11/26.
//

import SwiftUI



//TODO: Update the view for Update Medications

struct AddMedicatonView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var medicationName: String = ""
    @State private var medicationComposition: String = ""
    @State private var medicationPower: String = ""
    @State private var medicationForm: String = ""
    @State private var medicationCategory: String = ""
    @State private var medicationDirection: String = ""
    @State private var explainSickness: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var notes: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 8)
            
            ScrollView {
                VStack {
                    imageSection
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
        .background(.white)
    }
    
    private var header: some View {
        ZStack {
            
            //center title
            Text("Add Medication")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
            
            
            //actions
            HStack {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
        }
    }
    
    private var imageSection: some View {
        VStack(spacing: 12) {
            Image("capsule_tablet")
                .resizable()
                .scaledToFill()
                .clipped()
                .padding(40)
                .frame(width: 120, height: 120)
                .background(.red.opacity(0.25))
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )
            
            
            Text("Add a Photo (Optional)")
                .font(.body)
                
        }
    }
}

#Preview {
    AddMedicatonView()
}
