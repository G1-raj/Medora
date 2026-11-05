//
//  DoseOverviewView.swift
//  Medora
//
//  Created by Govine Rajput on 05/11/26.
//


import SwiftUI
import Charts

struct DoseStatus: Identifiable {
    let id = UUID()
    let title: String
    let count: Int
    let color: Color
}

struct DoseOverviewView: View {

    let doses: [DoseStatus] = [
        DoseStatus(title: "Taken", count: 25, color: Color(red: 0.25, green: 0.53, blue: 0.40)),
        DoseStatus(title: "Late", count: 2, color: Color(red: 1.0, green: 0.75, blue: 0.32)),
        DoseStatus(title: "Missed", count: 2, color: Color(red: 0.94, green: 0.39, blue: 0.43))
    ]

    private var totalDoses: Int {
        doses.reduce(0) { $0 + $1.count }
    }

    private func percentage(for count: Int) -> Int {
        guard totalDoses > 0 else { return 0 }
        return Int((Double(count) / Double(totalDoses) * 100).rounded())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            // Header
            VStack(alignment: .leading, spacing: 3) {
                Text("Doses Overview")
                    .font(.system(size: 15, weight: .semibold))

                Text("This week")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }

            // Chart and Legend
            HStack(spacing: 12) {

                // Donut Chart
                ZStack {
                    Chart(doses) { dose in
                        SectorMark(
                            angle: .value("Doses", dose.count),
                            innerRadius: .ratio(0.68),
                        )
                        .foregroundStyle(dose.color)
                    }
                    .chartLegend(.hidden)

                    // Center Text
                    VStack(spacing: 3) {
                        Text("\(totalDoses)")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.primary)

                        Text("Total Doses")
                            .font(.system(size: 10))
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 150, height: 150)

                // Legend
                VStack(spacing: 17) {
                    ForEach(doses) { dose in
                        HStack(spacing: 8) {

                            Circle()
                                .fill(dose.color)
                                .frame(width: 11, height: 11)

                            Text("\(dose.count)")
                                .font(.system(size: 14, weight: .semibold))
                                .frame(width: 23, alignment: .leading)

                            Text(dose.title)
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)

                            Spacer(minLength: 2)

                            Text("\(percentage(for: dose.count))%")
                                .font(.system(size: 13, weight: .medium))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 8)
        }
        .padding(16)
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    DoseOverviewView()
        .padding()
        .background(Color(red: 0.95, green: 0.96, blue: 0.92))
}

