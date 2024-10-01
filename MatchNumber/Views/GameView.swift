//
//  ContentView.swift
//  MatchNumber
//
//  Created by Utsav Shah on 21/09/24.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = NumbersViewModel() // Use StateObject to observe the ViewModel
    @State private var revealedNumbers: [Int] = [] // Track revealed numbers
    @State private var isProcessing: Bool = false // Track if processing is in progress
    @State private var totalMatched: Int = 0
    @State private var attempts: Int = 0
    @State private var isGameComplete: Bool = false

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width - (5 * 10) - 8
            let screenHeight = geometry.size.height
            
            let numberOfColumns = 4
            let numberOfRows = 5
            let boxWidth = screenWidth / CGFloat(numberOfColumns)
            let boxHeight = screenHeight / CGFloat(numberOfRows)
            let boxSize = min(boxWidth, boxHeight) // Make sure each box stays square
            ZStack {
                VStack {
                    Text("Match Numbers")
                        .font(.largeTitle)
                    Spacer(minLength: 12)

                    HStack {
                        Text("Match Left:")
                        Text("\(totalMatched)")
                        Spacer()
                        Text("Attempts:")
                        Text("\(attempts)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 19)
                    Spacer(minLength: 8)
                    
                    NumberGridView(revealedNumbers: $revealedNumbers,
                                   totalMatched: $totalMatched,
                                   attempts: $attempts,
                                   isProcessing: $isProcessing,
                                   viewModel: viewModel,
                                   numberOfColumns: numberOfColumns,
                                   numberOfRows: numberOfRows,
                                   boxSize: boxSize)
                    
                    Spacer()
                    
                    Button(action: {
                        resetGame()
                    }, label: {
                        Text("Restart")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 220)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    })
                    Spacer(minLength: 12)
                }
                WinningView(isVisible: $isGameComplete)
                    .zIndex(1) // Ensure it's above other views
                    .zIndex(1) // Ensure it's above other views
                
            }
        }
        .onChange(of: totalMatched) { newValue in
            if newValue >= (viewModel.randomNumbers.count / 2) {
                withAnimation {
                    isGameComplete = true // Trigger animation when game is complete
                }
            }
        }
    }
    
    private func resetGame() {
         revealedNumbers = []
         totalMatched = 0
         attempts = 0
         isGameComplete = false // Reset the game completion state
         viewModel.shuffledNumbers()
     }
}

#Preview {
    GameView()
}
