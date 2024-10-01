//
//  NumberGridView.swift
//  MatchNumber
//
//  Created by Utsav Shah on 02/10/24.
//

import SwiftUI

struct NumberGridView: View {
    @Binding var revealedNumbers: [Int]
    @Binding var totalMatched: Int
    @Binding var attempts: Int
    @Binding var isProcessing: Bool
    @ObservedObject var viewModel: NumbersViewModel

    let numberOfColumns: Int
    let numberOfRows: Int
    let boxSize: CGFloat

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<numberOfRows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<numberOfColumns, id: \.self) { col in
                        let index = row * numberOfColumns + col
                        
                        Button(action: {
                            if isProcessing { return }
                            
                            if revealedNumbers.contains(index) {
                                // Already revealed
                            } else {
                                revealedNumbers.append(index)
                            }

                            if (revealedNumbers.count % 2) == 0 {
                                attempts += 1

                                if revealedNumbers.count >= 2 {
                                    let lastSecondIndex = revealedNumbers[revealedNumbers.count - 2]
                                    let lastIndex = revealedNumbers.last!
                                    
                                    let lastSecondVal = viewModel.randomNumbers[lastSecondIndex]
                                    let currentVal = viewModel.randomNumbers[lastIndex]
                                    
                                    if lastSecondVal == currentVal {
                                        totalMatched += 1
                                    } else {
                                        isProcessing = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            revealedNumbers.removeLast(2)
                                            isProcessing = false
                                        }
                                    }
                                }
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


//#Preview {
//    NumberGridView()
//}
