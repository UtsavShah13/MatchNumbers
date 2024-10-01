//
//  WinningView.swift
//  MatchNumber
//
//  Created by Utsav Shah on 02/10/24.
//

import SwiftUI

struct WinningView: View {
    @Binding var isVisible: Bool
    @State private var scale: CGFloat = 1.0 // Scale for the win animation

    var body: some View {
        if isVisible {
            ZStack {
                Color.black.opacity(0.5) // Dark background
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isVisible = false // Hide the view on tap
                        }
                    }

                VStack {
                    Text("🎉 You Win! 🎉")
                        .font(.largeTitle)
                        .scaleEffect(scale) // Scale effect
                        .opacity(Double(scale)) // Opacity change
                        .onAppear {
                            withAnimation(Animation.easeOut(duration: 1).repeatForever(autoreverses: true)) {
                                scale = 1.5 // Scale up
                            }
                        }
                        .transition(.scale) // Transition effect
                        .padding()
                }
                .zIndex(1) // Ensure it's above other views
            }
        }
    }
}

#Preview {
    WinningView(isVisible: .constant(true))
}
