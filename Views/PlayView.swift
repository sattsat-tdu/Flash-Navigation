//
//  SwiftUIView.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/17
//  
//

import SwiftUI

struct PlayView: View {
    
    @StateObject var viewModel = PlayViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            Group {
                switch viewModel.playState {
                case .ready:
                    readyView
                case .choice:
                    AnswerInputView(viewModel: viewModel)
                case .result:
                    ResultView(viewModel: viewModel)
                }
            }
            .animation(.default, value: viewModel.playState)
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.primary.opacity(0.4))
                        .font(.system(size: 56, weight: .bold))
                })
                .padding()
            }
            .disabled(viewModel.disableFlg)
            .navigationDestination(for: Int.self) { number in
                FlashNumberView(number: number)
            }
        }
    }
}

// MARK: views
extension PlayView {
    
    
    private var readyView: some View {
        VStack(spacing: 48) {
            
            Text("Are you ready?")
                .font(.system(size: 80)).bold()
            
            Button(action: {
                viewModel.startFlashNavigation()
            }, label: {
                Text("START")
                    .capsuleButtonStyle()
                    .padding(.horizontal, 48)
            })
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PlayView()
}
