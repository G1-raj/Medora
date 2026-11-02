//
//  ProfileView.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                //appbar
                header
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                
                
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        mainBody
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 22)
                    .padding(.bottom, 24)
                    .frame(maxWidth: 500)
                    .frame(maxWidth: .infinity)
                }
                .scrollDismissesKeyboard(.interactively)
                .background(.background)
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("Profile")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
    
    private var mainBody: some View {
        VStack(alignment: .leading, spacing: 8) {
            ProfileCard(
                userName: "Govind Rajput",
                userEmail: "govindrajput7767@gmail.com"
            )
        }
    }
}

#Preview {
    ProfileView()
}
