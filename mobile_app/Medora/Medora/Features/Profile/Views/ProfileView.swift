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
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        profileSection
                        statsSection
                        accountSection
                        settingsSection
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 22)
                    .padding(.bottom, 32)
                    .frame(maxWidth: 500)
                    .frame(maxWidth: .infinity)
                }
                .background(Color(.systemGroupedBackground))
            }
            .background(Color(.systemGroupedBackground))
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("Profile")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundStyle(.primary)

                Text("Manage your account and health details")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                // Navigate to settings
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 44, height: 44)
                    .background(.white)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.black.opacity(0.05), lineWidth: 1)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Profile

    private var profileSection: some View {
        ProfileCard(
            userName: "Govind Rajput",
            userEmail: "govindrajput7767@gmail.com"
        )
    }

    // MARK: - Stats

    private var statsSection: some View {
        HStack(spacing: 0) {
            statItem(
                value: "24",
                title: "Medications",
                icon: "pills.fill",
                color: .themeAccent
            )

            Rectangle()
                .fill(.gray.opacity(0.2))
                .frame(width: 1, height: 42)

            statItem(
                value: "86%",
                title: "Adherence",
                icon: "chart.line.uptrend.xyaxis",
                color: .green
            )
        }
        .padding(.vertical, 20)
        .cardStyle()
    }

    private func statItem(
        value: String,
        title: String,
        icon: String,
        color: Color
    ) -> some View {
        VStack(spacing: 7) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(color)

                Text(value)
                    .font(.system(size: 23, weight: .bold))
                    .foregroundStyle(.primary)
            }

            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Account Options

    private var accountSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(
                title: "Health & Account",
                subtitle: "Your personal health information"
            )

            VStack(spacing: 0) {
                listTile(
                    label: "My Medical Profile",
                    subLabel: "Age, weight, blood type, conditions",
                    icon: "stethoscope",
                    iconColor: .themeAccent
                ) {}

                tileDivider

                listTile(
                    label: "Caregivers",
                    subLabel: "Add family or caregivers",
                    icon: "person.2.fill",
                    iconColor: .orange
                ) {}

                tileDivider

                listTile(
                    label: "Pharmacy",
                    subLabel: "Preferred pharmacy & contact",
                    icon: "pills.fill",
                    iconColor: .themeAccent
                ) {}

                tileDivider

                listTile(
                    label: "Reports",
                    subLabel: "Export your health data",
                    icon: "doc.text.fill",
                    iconColor: .purple
                ) {}
            }
            .cardStyle()
        }
    }

    // MARK: - App Settings

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(
                title: "App Settings",
                subtitle: "Customize your experience"
            )

            VStack(spacing: 0) {
                listTile(
                    label: "Notifications",
                    subLabel: "Manage reminders and alerts",
                    icon: "bell.badge.fill",
                    iconColor: .orange
                ) {}

                tileDivider

                listTile(
                    label: "Language",
                    subLabel: "English (US)",
                    icon: "globe",
                    iconColor: .themeAccent
                ) {}
            }
            .cardStyle()
        }
    }

    // MARK: - Components

    private func sectionHeader(
        title: String,
        subtitle: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.primary)

            Text(subtitle)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
    }

    private var tileDivider: some View {
        Divider()
            .padding(.leading, 56)
    }

    private func listTile(
        label: String,
        subLabel: String,
        icon: String,
        iconColor: Color,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(iconColor)
                    .frame(width: 40, height: 40)
                    .background(iconColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.primary)

                    Text(subLabel)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 4)

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.tertiary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Reusable Card Style

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
    ProfileView()
}
