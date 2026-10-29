//
//  OnboardingView.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct OnboardingContent {
    let imageUrl: String
    let title: String
    let subTitle: String
}


struct OnboardingView: View {

    let content: [OnboardingContent] = [
        OnboardingContent(
            imageUrl: "medicine_box",
            title: "Never miss \na dose",
            subTitle: """
            Get timely reminders for all your
            medications and build a healthier,
            more consistent routine.
            """
        ),
        OnboardingContent(
            imageUrl: "list",
            title: "Track your \nprogress",
            subTitle: """
            See your adherence, build healthy
            habits, and celebrate your progress
            over time.
            """
        ),
        OnboardingContent(
            imageUrl: "schedule",
            title: "Stay on top \nof refills",
            subTitle: """
            Get reminders for upcoming refills
            so you're always prepared.
            """
        ),
        OnboardingContent(
            imageUrl: "elderly",
            title: "Care together",
            subTitle: """
            Share progress with family or
            caregivers for extra support
            and peace of mind.
            """
        )
    ]

    @State private var currentPage = 0
    @State private var isMovingForward = true
    @State private var navigateToAuth = false

    private var isLastPage: Bool {
        currentPage == content.count - 1
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                OnboardingComponent(
                    imageUrl: content[currentPage].imageUrl,
                    headTitle: content[currentPage].title,
                    subTitle: content[currentPage].subTitle
                )
                .id(currentPage)
                .transition(
                    .asymmetric(
                        insertion: .offset(
                            x: isMovingForward ? 35 : -35
                        )
                        .combined(with: .opacity),

                        removal: .offset(
                            x: isMovingForward ? -20 : 20
                        )
                        .combined(with: .opacity)
                    )
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 30)
                            .onEnded { value in
                                let horizontal = value.translation.width

                                guard abs(horizontal) > 50 else { return }

                                if horizontal < 0 {
                                    goToPage(currentPage + 1)
                                } else {
                                    goToPage(currentPage - 1)
                                }
                            }
                )

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationDestination(isPresented: $navigateToAuth) {
                AuthNavigator()
            }
            .safeAreaInset(edge: .bottom) {
                bottomButton
            }
        }
    }

    private var bottomButton: some View {
        HStack {
            Spacer(minLength: 0)

            Button(action: handleButtonTap) {
                ZStack {
                    Image(systemName: "arrow.right")
                        .font(.title2.bold())
                        .opacity(isLastPage ? 0 : 1)
                        .scaleEffect(isLastPage ? 0.5 : 1)

                    Text("Get Started")
                        .font(.title3.bold())
                        .opacity(isLastPage ? 1 : 0)
                        .scaleEffect(isLastPage ? 1 : 0.85)
                }
                .foregroundStyle(.white)
                .frame(
                    maxWidth: isLastPage ? .infinity : 70
                )
                .frame(height: isLastPage ? 55 : 70)
                .background(.themeAccent)
                .clipShape(Capsule())
                .contentShape(Capsule())
            }
            .buttonStyle(.plain)
            .frame(
                maxWidth: isLastPage ? .infinity : nil
            )
            .accessibilityLabel(
                isLastPage ? "Get Started" : "Next page"
            )
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .animation(
            .spring(response: 0.5, dampingFraction: 0.85),
            value: currentPage
        )
    }
    
    private func handleButtonTap() {
        if isLastPage {
            navigateToAuth = true
            return
        }

        goToPage(currentPage + 1)
    }
    
    private func goToPage(_ page: Int) {
        guard content.indices.contains(page) else { return }

        isMovingForward = page > currentPage

        withAnimation(
            .spring(response: 0.55, dampingFraction: 0.88)
        ) {
            currentPage = page
        }
    }
}

#Preview {
    OnboardingView()
}


#Preview {
    OnboardingView()
}
