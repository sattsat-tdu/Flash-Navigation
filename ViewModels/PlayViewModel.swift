//
//  PlayViewModel.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/17
//  
//

import Foundation
import SwiftUI

enum PlayState {
    case ready
    case choice
    case result
}

@MainActor
final class PlayViewModel: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var answers: [Int] = []
    @Published var playState: PlayState = .ready
    @Published var choices: [Int] = []
    @Published var inputNumbers: [Int?]
    @Published var message: String = "Long press to start dragging."
    @Published var isCorrect: Bool?
    @Published var disableFlg = false
    
    @Published var startTime: Date? = nil
    @Published var elapsedTime: TimeInterval = 0
    @Published var replayCount: Int = -1
    @Published var mistakeCount: Int = 0
    
    let count: Int
    let digit: Int
    
    init() {
        let savedCount = UserDefaults.standard.integer(forKey: UserDefaultKeys.count.rawValue)
        self.digit = UserDefaults.standard.integer(forKey: UserDefaultKeys.digit.rawValue)
        self.count = savedCount
        self.inputNumbers = Array(repeating: nil, count: count)
        let answers: [Int] = self.createNumbers(count: count, digit: digit)
        self.answers = answers
        self.choices = answers.shuffled()
    }
    
    func createNumbers(count: Int = 10, digit: Int = 1) -> [Int] {
        var numbers: Set<Int> = []
        
        let minValue: Int
        let maxValue: Int
        let maxUniqueCount: Int
        
        switch digit {
        case 1:
            minValue = 1
            maxValue = 9
        case 2:
            minValue = 10
            maxValue = 99
        case 3:
            minValue = 100
            maxValue = 999
        default:
            minValue = 1
            maxValue = 9
        }

        maxUniqueCount = maxValue - minValue + 1

        let finalCount = min(count, maxUniqueCount)

        while numbers.count < finalCount {
            let number = Int.random(in: minValue...maxValue)
            numbers.insert(number)
        }
        
        return Array(numbers).shuffled()
    }
    
    private func startTimer() {
        guard startTime == nil else { return }
        
        startTime = Date()
        elapsedTime = 0
    }
    
    private func stopTimer() {
        if let startTime = startTime {
            elapsedTime = Date().timeIntervalSince(startTime)
        }
        startTime = nil
    }

    // フラッシュ暗算ナビゲーション開始
    func startFlashNavigation() {
        path = NavigationPath()
        replayCount += 1

        Task {
            for number in answers {
                path.append(number)
                try? await Task.sleep(nanoseconds: 500_000_000)
            }
            playState = .choice
            startTimer()
            path.removeLast(path.count)
        }
    }

    func removeFromInputNumbers(_ number: Int) {
        inputNumbers.indices.forEach { index in
            if inputNumbers[index] == number {
                inputNumbers[index] = nil
            }
        }

        if !choices.contains(number) {
            choices.append(number)
        }
    }
    
    
    func handleDrop(_ number: Int, at index: Int) {
        let currentNumber = inputNumbers[index]
        
        guard number != currentNumber else { return }
        
        //input同士の移動なら
        if let fromIndex = inputNumbers.firstIndex(where: { $0 == number }) {
            if let currentNumber {
                swapNumbers(from: currentNumber, to: fromIndex)
            } else {
                inputNumbers[fromIndex] = nil
            }
        } else {
            choices.removeAll { $0 == number }
            if let currentNumber {
                choices.append(currentNumber)
            }
        }
        
        inputNumbers[index] = number
    }
    
    func swapNumbers(from: Int, to index: Int) {
        if let fromIndex = inputNumbers.firstIndex(where: { $0 == from }) {
            inputNumbers.swapAt(fromIndex, index)
        }
    }
    
    func reset() {
        inputNumbers = Array(repeating: nil, count: inputNumbers.count)
        choices.removeAll()
        choices = answers.shuffled()
    }
    
    func onClickedAnswerButton() {
        let userAnswer = inputNumbers.compactMap { $0 }

        if userAnswer.count != answers.count {
            setErrorMessage("Please fill all the frames.")
            return
        }
        
        var isAllCorrect = true
        
        for index in inputNumbers.indices {
            if userAnswer[index] != answers[index] {
                choices.append(userAnswer[index])
                inputNumbers[index] = nil
                isAllCorrect = false
            }
        }
        self.isCorrect = isAllCorrect
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isCorrect = nil
            if isAllCorrect {
                self.playState = .result
                self.stopTimer()
            } else { self.mistakeCount += 1 }
        }
    }

    func setErrorMessage(_ message: String) {
        disableFlg = true
        self.message = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            self.message = "Long press to start dragging."
            disableFlg = false
        }
    }
}
