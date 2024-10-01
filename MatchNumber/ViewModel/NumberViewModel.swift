//
//  NumberViewModel.swift
//  MatchNumber
//
//  Created by Utsav Shah on 02/10/24.
//

import Foundation

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
    
    func shuffledNumbers() {
        self.randomNumbers.shuffle()
    }
}
