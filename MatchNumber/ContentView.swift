//
//  ContentView.swift
//  MatchNumber
//
//  Created by Utsav Shah on 21/09/24.
//

import SwiftUI

class NumbersViewModel: ObservableObject {
    // Published array that the view will observe
    @Published var randomNumbers: [Int] = []
    
    init() {
        generateRandomNumbers()
    }
    
    // Function to generate numbers from 1 to 10, repeated twice, and shuffle them
    func generateRandomNumbers() {
        let numbers = Array(1...10)
        self.randomNumbers = (numbers + numbers).shuffled()
    }
}

struct ContentView: View {
    @StateObject private var viewModel = NumbersViewModel() // Use StateObject to observe the ViewModel
    @State private var revealedNumbers: [Int] = [] // Track revealed numbers
    @State private var isProcessing: Bool = false // Track if processing is in progress
    @State private var totalMatched: Int = 0

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width - (5 * 10) - 8
            let screenHeight = geometry.size.height
            
            let numberOfColumns = 4  // 10 columns
            let numberOfRows = 5     // 10 rows
            let boxWidth = screenWidth / CGFloat(numberOfColumns)
            let boxHeight = screenHeight / CGFloat(numberOfRows)
            let boxSize = min(boxWidth, boxHeight) // Make sure each box stays square
            let arr = Array(1...20)
            VStack(spacing: 12) {
                Text("Match Numbers")
                    .font(.largeTitle)
                HStack {
                    Text("Match Left:")
                    Text("\(totalMatched)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 19)
                VStack(spacing: 10) {
                    ForEach(0..<numberOfRows, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<numberOfColumns, id: \.self) { col in
                                let index = row * numberOfColumns + col

                                Button(action: {
                                    // Disable interaction while processing
                                    if isProcessing { return }

                                    if revealedNumbers.contains(index) {
                                        } else {
                                            revealedNumbers.append(index)
                                        }

                                    if (revealedNumbers.count % 2) == 0 {
                                        print("even")
                                        
                                        if revealedNumbers.count >= 2 {
                                            let lastSecondIndex = revealedNumbers[revealedNumbers.count - 2]
                                            let lastIndex = revealedNumbers.last!
                                            
                                            // Access the values from randomNumbers
                                            let lastSecondVal = viewModel.randomNumbers[lastSecondIndex]
                                            let currentVal = viewModel.randomNumbers[lastIndex]
                                            
                                            print("Second last value: \(lastSecondVal)")
                                            print("Last value: \(currentVal)")
                                            
                                            if lastSecondVal == currentVal {
                                                print("Match!")
                                                totalMatched += 1
                                            } else {
                                                print("No match!")
                                                // Optionally, remove the last two revealed numbers if they don't match
                                                isProcessing = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
                                                    // Optional: Add a delay for visual feedback
                                                    revealedNumbers.removeLast(2)
                                                    isProcessing = false
                                                }                       
                                            }
                                        }
                                    } else {
                                            print("odd")
                                        }
                                    
                                }, label: {
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(width: boxSize, height: boxSize)
                                            if revealedNumbers.contains(index),
                                               viewModel.randomNumbers.indices.contains(index) {
                                                Text("\(viewModel.randomNumbers[index])")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 25))
                                            }
                                        }
                                    })
                                }
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
