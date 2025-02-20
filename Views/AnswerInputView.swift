//
//  SwiftUIView.swift
//  FlashNavigation
//
//  Created by SATTSAT on 2025/02/17
//
//

import SwiftUI

struct AnswerInputView: View {
    
    @ObservedObject var viewModel: PlayViewModel
    @State private var targetedIndex: Int?
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    
    var body: some View {
        VStack {
            headerView()
            
            LazyVGrid(columns: columns) {
                ForEach(Array(viewModel.inputNumbers.enumerated()), id: \.offset) { index, value in
                    VStack {
                        Text("\(index + 1)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        InputFrame(number: value)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(.yellow, lineWidth: index == targetedIndex ? 4: 0)
                            )
                            .dropDestination(for: Int.self) { droppedNumbers, _ in
                                if let number = droppedNumbers.first {
                                    viewModel.handleDrop(number, at: index)
                                }
                                return true
                            } isTargeted: { isTargeted in
                                targetedIndex = isTargeted ? index : nil
                            }
                            .ifLet(value) { view, unwrappedValue in
                                view.draggable(unwrappedValue) {
                                    NumberCell(number: unwrappedValue)
                                }
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(alignment: .leading, spacing: 24) {
                
                HStack {
                    Text("Choices")
                        .font(.title.bold())
                        .frame(width: 120)
                    
                    Text(viewModel.message)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                    
                    if viewModel.inputNumbers.contains(where: { $0 != nil }) {
                        Button(action: {
                            viewModel.reset()
                        }, label: {
                            Label("Reset", systemImage: "repeat") 
                        })
                        .frame(width: 120)
                    } else {
                        Spacer(minLength: 120)
                    }
                }
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.choices, id: \.self) { number in
                        NumberCell(number: number)
                            .draggable(number) {
                                NumberCell(number: number)
                            }
                    }
                }
                .frame(maxHeight: .infinity)
                
                HStack(spacing: 24) {
                    Button(action: {
                        viewModel.startFlashNavigation()
                    }, label: {
                        Text("Replay").capsuleButtonStyle()
                    })
                    
                    Button(action: {
                        viewModel.onClickedAnswerButton()
                    }, label: {
                        Text("Answer").capsuleButtonStyle()
                    })
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .dropDestination(for: Int.self) { droppedNumbers, _ in
                if let number = droppedNumbers.first {
                    viewModel.removeFromInputNumbers(number)
                }
                return true
            }
        }
        .padding()
        .overlay {
            if let isCorrect = viewModel.isCorrect {
                Image(systemName: isCorrect ? "circle" : "xmark")
                    .resizable()
                    .foregroundStyle(isCorrect ? .red : .blue)
                    .scaledToFit()
                    .frame(height: 400)
            }
        }
    }
}

// MARK: views
extension AnswerInputView {
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            Text("Drag and drop in the correct order")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    NavigationStack {
        AnswerInputView(viewModel: PlayViewModel())
    }
}


