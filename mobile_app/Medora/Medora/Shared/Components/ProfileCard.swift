//
//  ProfileCard.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//


import SwiftUI
import PhotosUI
import UIKit

struct ProfileCard: View {

    let userName: String
    let userEmail: String

    var onEditProfile: () -> Void = {}

    private let imageUrl = URL(
        string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtGBO7-ORjBhGi-57w0He9t1qmNb3CFAARurOE8UkngDZN-RxxZse28nDV&s=10"
    )

    @State private var selectedImage: UIImage?
    @State private var selectedPhoto: PhotosPickerItem?

    @State private var showOptions = false
    @State private var showGallery = false
    @State private var showCamera = false
    @State private var isLoadingImage = false

    private let backgroundColor = Color(
        red: 240 / 255,
        green: 246 / 255,
        blue: 237 / 255
    )

    var body: some View {
        VStack(spacing: 0) {
            profileHeader
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(.black.opacity(0.04), lineWidth: 1)
        }
        .shadow(
            color: .black.opacity(0.045),
            radius: 12,
            x: 0,
            y: 5
        )
        .confirmationDialog(
            "Profile Picture",
            isPresented: $showOptions,
            titleVisibility: .visible
        ) {
            Button("Choose from Gallery") {
                showGallery = true
            }

            Button("Take Photo") {
                showCamera = true
            }

            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Choose how you want to update your profile picture.")
        }
        .photosPicker(
            isPresented: $showGallery,
            selection: $selectedPhoto,
            matching: .images
        )
        .onChange(of: selectedPhoto) { _, newValue in
            loadSelectedImage(newValue)
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(selectedImage: $selectedImage)
        }
    }

    // MARK: - Header

    private var profileHeader: some View {
        ZStack {
            decorativeBackground

            VStack(spacing: 12) {
                profileImage

                VStack(spacing: 5) {
                    Text(userName)
                        .font(.system(size: 21, weight: .bold))
                        .foregroundStyle(.black)
                        .lineLimit(1)

                    Text(userEmail)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                editProfileButton
                    .padding(.top, 5)
            }
            .padding(.vertical, 28)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }

    // MARK: - Decorative Background

    private var decorativeBackground: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(.white.opacity(0.25))
                    .frame(width: 180, height: 180)
                    .offset(
                        x: geometry.size.width / 2,
                        y: -geometry.size.height / 2
                    )

                Image("left_leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110)
                    .opacity(0.55)
                    .rotationEffect(.degrees(-10))
                    .offset(
                        x: -geometry.size.width / 2 + 30,
                        y: geometry.size.height / 2 - 15
                    )

                Image("right_leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 105)
                    .opacity(0.55)
                    .rotationEffect(.degrees(-30))
                    .offset(
                        x: geometry.size.width / 2 - 25,
                        y: -geometry.size.height / 2 + 25
                    )
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .allowsHitTesting(false)
    }

    // MARK: - Profile Image

    private var profileImage: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    remoteImage
                }
            }
            .frame(width: 116, height: 116)
            .clipShape(Circle())
            .padding(5)
            .background(.white)
            .clipShape(Circle())
            .shadow(
                color: .black.opacity(0.10),
                radius: 8,
                x: 0,
                y: 3
            )

            Button {
                showOptions = true
            } label: {
                Image(systemName: "camera.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(.themeAccent)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Change profile picture")
        }
    }

    // MARK: - Remote Image

    private var remoteImage: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                placeholderImage

            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray.opacity(0.08))

            @unknown default:
                placeholderImage
            }
        }
    }

    private var placeholderImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.gray.opacity(0.5))
            .padding(15)
            .background(.gray.opacity(0.08))
    }

    // MARK: - Edit Profile

    private var editProfileButton: some View {
        Button(action: onEditProfile) {
            HStack(spacing: 7) {
                Image(systemName: "pencil")
                    .font(.system(size: 11, weight: .semibold))

                Text("Edit Profile")
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundStyle(.themeAccent)
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
            .background(.white.opacity(0.85))
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Load Gallery Image

    private func loadSelectedImage(_ photo: PhotosPickerItem?) {
        guard let photo else { return }

        Task {
            isLoadingImage = true
            defer { isLoadingImage = false }

            do {
                guard let data = try await photo.loadTransferable(
                    type: Data.self
                ),
                let image = UIImage(data: data) else {
                    return
                }

                await MainActor.run {
                    selectedImage = image
                }
            } catch {
                print("Failed to load profile image: \(error)")
            }
        }
    }
}

#Preview {
    ProfileCard(
        userName: "Govind Rajput",
        userEmail: "govindrajput7767@gmail.com"
    )
    .padding(.horizontal, 24)
}
