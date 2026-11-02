//
//  CirculatProgressIndicator.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import SwiftUI

struct CirculatProgressIndicator: View {
    
    var progress: Double = 0.6
    
    private let lineWidth: CGFloat = 6

    @State private var animatedProgress: Double = 0

    private var clampedProgress: Double {
        min(max(progress, 0), 1)
    }
    
    var body: some View {
        ZStack {
            //light background of progress indicator track
            Circle()
                .stroke(
                    .white.opacity(0.15),
                    style: StrokeStyle(lineWidth: lineWidth)
                )
            
            //animated progress ring
            Circle()
                .trim(from: 0, to: animatedProgress)
                .stroke(
                    .white,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .shadow(
                    color: .white.opacity(0.25),
                    radius: 3,
                    x: 0,
                    y: 1
                )
            
            //center image
            Image("sprout")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 35, height: 35)
        }
        .frame(width: 80, height: 80)
        .onAppear {
            withAnimation(.spring(
                response: 1.0,
                dampingFraction: 0.8
            )) {
                animatedProgress = clampedProgress
            }
        }
        .onChange(of: progress) { _, newValue in
            withAnimation(.spring(
                response: 0.8,
                dampingFraction: 0.8
            )) {
                animatedProgress = min(max(newValue, 0), 1)
            }
        }
    }
}

#Preview {
    CirculatProgressIndicator()
}
