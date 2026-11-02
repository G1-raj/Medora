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

    private let imageUrl = URL(
        string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtGBO7-ORjBhGi-57w0He9t1qmNb3CFAARurOE8UkngDZN-RxxZse28nDV&s=10"
    )

    @State private var selectedImage: UIImage?
    @State private var selectedPhoto: PhotosPickerItem?

    @State private var showOptions = false
    @State private var showCamera = false
    @State private var showGallery = false

    var body: some View {
        VStack(spacing: 12) {
            profileHeader
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.black.opacity(0.04), lineWidth: 1)
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            x: 0,
            y: 4
        )
        .confirmationDialog(
            "Change Profile Picture",
            isPresented: $showOptions
        ) {
            Button("Choose from Gallery") {
                showGallery = true
            }

            Button("Take Photo") {
                showCamera = true
            }

            Button("Cancel", role: .cancel) {}
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

    // MARK: - Profile Header

    private var profileHeader: some View {
        ZStack {
            cardBackground

            leafImages

            profileContent
        }
    }

    // MARK: - Background

    private var cardBackground: some View {
        Color(
            red: 240.0 / 255.0,
            green: 246.0 / 255.0,
            blue: 237.0 / 255.0
        )
    }

    // MARK: - Leaf Images

    private var leafImages: some View {
        ZStack {
            Image("left_leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 80)
                .offset(x: -120, y: 50)

            Image("right_leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 80)
                .rotationEffect(.degrees(-30))
                .offset(x: 120, y: -50)
        }
    }

    // MARK: - Profile Content

    private var profileContent: some View {
        VStack(spacing: 12) {
            profileImage

            Text(userName)
                .font(.title)
                .foregroundStyle(.black)
                .bold()

            Text(userEmail)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 30)
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
            .frame(width: 150, height: 150)
            .clipShape(Circle())

            Button {
                showOptions = true
            } label: {
                Image(systemName: "camera.fill")
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(.themeAccent)
                    .clipShape(Circle())
            }
        }
    }

    // MARK: - Remote Image

    private var remoteImage: some View {
        AsyncImage(url: imageUrl) { phase in

            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundStyle(.gray)
            } else {
                ProgressView()
            }
        }
    }

    // MARK: - Load Gallery Image

    private func loadSelectedImage(_ photo: PhotosPickerItem?) {
        Task {
            guard let data = try? await photo?.loadTransferable(
                type: Data.self
            ),
            let image = UIImage(data: data) else {
                return
            }

            selectedImage = image
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
