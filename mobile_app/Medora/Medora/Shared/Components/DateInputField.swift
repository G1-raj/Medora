//
//  DateInputField.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//


import SwiftUI

struct DateInputField: View {

    let title: String
    @Binding var date: Date?
    var isRequired: Bool = false

    @State private var showDatePicker = false
    @State private var selectedDate = Date()

    private let accentColor = Color(
        red: 0.16,
        green: 0.40,
        blue: 0.31
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // Field title
            HStack(spacing: 3) {
                Text(title)
                    .foregroundStyle(.primary)

                if isRequired {
                    Text("*")
                        .foregroundStyle(.red)
                }

                if !isRequired {
                    Text("(Optional)")
                        .foregroundStyle(.secondary)
                }
            }
            .font(.system(size: 14, weight: .medium))

            // Date input field
            Button {
                selectedDate = date ?? Date()
                showDatePicker = true
            } label: {
                HStack(spacing: 10) {

                    Image(systemName: "calendar")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)

                    Text(
                        date?.formatted(
                            .dateTime
                                .month(.abbreviated)
                                .day()
                                .year()
                        ) ?? "Select date"
                    )
                    .font(.system(size: 14))
                    .foregroundStyle(
                        date == nil
                        ? Color.secondary
                        : Color.primary
                    )

                    Spacer()
                }
                .padding(.horizontal, 12)
                .frame(height: 46)
                .background(Color.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 9)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(
                            Color.gray.opacity(0.25),
                            lineWidth: 1
                        )
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showDatePicker) {
                datePickerSheet
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    private var datePickerSheet: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Select \(title)",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .tint(accentColor)
                .padding()
            }
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showDatePicker = false
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        date = selectedDate
                        showDatePicker = false
                    }
                    .foregroundStyle(accentColor)
                }

                if !isRequired && date != nil {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Clear Date", role: .destructive) {
                            date = nil
                            showDatePicker = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    
    @Previewable @State var date: Date? = Date()
    
    DateInputField(
        title: "Start Date",
        date: $date,
        isRequired: true
    )
}
