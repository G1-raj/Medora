//
//  SettingsView.swift
//  Medora
//
//  Created by Govine Rajput on 02/11/26.
//

import SwiftUI

struct SettingsView: View {
    
    
    @State private var isMedicationReminderOn: Bool = false
    @State private var isRefillReminderOn: Bool = false
    @State private var isStreakNotificationOn: Bool = false
    @State private var isHealthInsightsNotificationOn: Bool = false
    @State private var isGeneralNotificationOn: Bool = false
    
    @State private var isBiometric: Bool = false
    @State private var isAppLock: Bool = false
    
    var body: some View {
        
        header
        
        VStack(spacing: 0) {
            
            ScrollView(showsIndicators: false) {
                notificatonsSettings
                    .padding(.bottom, 20)
                
                prefrences
                    .padding(.bottom, 20)
                
                privacy
            }
            .padding(.horizontal, 24)
            .padding(.top, 22)
            .padding(.bottom, 32)
            .frame(maxWidth: 500)
            .frame(maxWidth: .infinity)
        }
        .background(.white)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        ZStack {
            //center title
            Text("App Settings")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
            
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .frame(height: 44)
    }
    
    private var notificatonsSettings: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notifications")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.primary)
            
            VStack(spacing: 0) {
                SwitchButtonListTile(
                    label: "Medication Remainders",
                    subLabel: "Reminders for your daily medications",
                    icon: "pills.fill",
                    iconColor: .red,
                    isEnabled: $isMedicationReminderOn
                ) {}
                
                SwitchButtonListTile(
                    label: "Refill Reminders",
                    subLabel: "Get notified before you run out",
                    icon: "calendar",
                    iconColor: .blue,
                    isEnabled: $isRefillReminderOn
                ) {}
                
                SwitchButtonListTile(
                    label: "Streak Notifications",
                    subLabel: "Motivational streak updates",
                    icon: "flame",
                    iconColor: .orange,
                    isEnabled: $isStreakNotificationOn
                ) {}
                
                SwitchButtonListTile(
                    label: "Health Insights",
                    subLabel: "Weekly insights and tips",
                    icon: "chart.bar.fill",
                    iconColor: .themeAccent,
                    isEnabled: $isHealthInsightsNotificationOn
                ) {}
                
                SwitchButtonListTile(
                    label: "General Notifications",
                    subLabel: "App updates and important alerts",
                    icon: "bell.badge.fill",
                    iconColor: .green,
                    isEnabled: $isGeneralNotificationOn
                ) {}
            }
            .cardStyle()
        }
    }
    
    private var prefrences: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Reminder Preferences")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.primary)
            
            VStack(spacing: 0) {
                listTile(
                    icon: "clock",
                    label: "Default Reminder Time",
                    subLabel: "8:00 AM",
                    onTap: {}
                )
                
                listTile(
                    icon: "zzz",
                    label: "Snooze Duration",
                    subLabel: "10 Minutes",
                    onTap: {}
                )
            }
            .cardStyle()
        }
    }
    
    private var privacy: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Data & Privacy")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.primary)
            
            VStack(spacing: 0) {
                switchButtonListTile(
                    icon: "shield.fill",
                    label: "Face ID / Touch ID",
                    isEnabled: $isBiometric
                )
                
                switchButtonListTile(
                    icon: "lock",
                    label: "App Lock",
                    isEnabled: $isAppLock
                )
            }
            .cardStyle()
        }
    }
    
    private func listTile(
        icon: String,
        label: String,
        subLabel: String,
        onTap: @escaping () -> Void
    ) -> some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .foregroundStyle(.black)
            
            Text(label)
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(subLabel)
                .foregroundStyle(.gray)
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .frame(height: 50)
    }
    
    private func switchButtonListTile(
        icon: String,
        label: String,
        isEnabled: Binding<Bool>
    ) -> some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .foregroundStyle(.black)
            
            Text(label)
                .foregroundStyle(.black)
            
            Spacer()
            
            Toggle("", isOn: isEnabled)
                .labelsHidden()
                .tint(.themeAccent)
            
            
        }
        .frame(height: 50)
    }
}

private extension View {
    func cardStyle() -> some View {
        self
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.black.opacity(0.04), lineWidth: 1)
            }
            .shadow(
                color: .black.opacity(0.035),
                radius: 10,
                x: 0,
                y: 3
            )
    }
}

#Preview {
    SettingsView()
}
