//
//  HomeDashBoardView.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct HomeDashBoardView: View {
    
    
    @State private var isScreenEmpty: Bool = false
    @State var isNavigateToRefillTracker: Bool = false
    
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
            .navigationDestination(isPresented: $isNavigateToRefillTracker) {
                RefillTrackerView()
            }
        }
    }
}

#Preview {
    HomeDashBoardView()
}
