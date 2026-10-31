//
//  StraightProgressIndicator.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct StraightProgressIndicator: View {

    @State private var progress: CGFloat = 0.75

    private var clampedProgress: CGFloat {
        min(max(progress, 0), 1)
    }

    private var progressPercentage: Int {
        Int(clampedProgress * 100)
    }

    var body: some View {
        HStack(spacing: 10) {

            GeometryReader { geometry in
                ZStack(alignment: .leading) {

                    // Background track
                    Capsule()
                        .fill(.white.opacity(0.25))

                    // Filled progress
                    Capsule()
                        .fill(.white)
                        .frame(
                            width: geometry.size.width * clampedProgress
                        )
                        .animation(
                            .spring(response: 0.5, dampingFraction: 0.8),
                            value: progress
                        )
                }
            }
            .frame(height: 8)

            // Progress percentage
            Text("\(progressPercentage)%")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white)
                .fixedSize()
        }
    }
}

#Preview {
    VStack {
        StraightProgressIndicator()
    }
    .frame(height: 80)
    .padding(.horizontal)
    .background(.themeAccent)
    .padding(.horizontal, 30)
    
}
