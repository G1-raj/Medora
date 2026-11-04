//
//  AdherenceChartView.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//


import SwiftUI
import Charts

struct AdherenceDay: Identifiable {
    let id = UUID()
    let day: String
    let percentage: Double
}

struct AdherenceChartView: View {

    let adherenceRate: Int

    let data: [AdherenceDay] = [
        .init(day: "Mon", percentage: 55),
        .init(day: "Tue", percentage: 75),
        .init(day: "Wed", percentage: 95),
        .init(day: "Thu", percentage: 65),
        .init(day: "Fri", percentage: 85),
        .init(day: "Sat", percentage: 45),
        .init(day: "Sun", percentage: 75)
    ]

    private let accentColor = Color(
        red: 0.22,
        green: 0.52,
        blue: 0.39
    )

    var body: some View {
        VStack(spacing: 14) {

            // Header
            HStack {
                HStack(spacing: 4) {
                    Text("Adherence")
                        .font(.system(size: 14, weight: .semibold))

                    Text("(Last 7 days)")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(adherenceRate)%")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(accentColor)
            }

            // Bar Chart
            Chart(data) { item in
                BarMark(
                    x: .value("Day", item.day),
                    y: .value("Adherence", item.percentage),
                    width: 15
                )
                .foregroundStyle(accentColor.gradient)
                .cornerRadius(5)
            }
            .chartYScale(domain: 0...110)
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel()
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(height: 90)
        }
        .padding(14)
        .background(
            Color.white.opacity(0.75)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    AdherenceChartView(adherenceRate: 86)
        .padding()
        .background(Color(red: 0.95, green: 0.96, blue: 0.92))
}

