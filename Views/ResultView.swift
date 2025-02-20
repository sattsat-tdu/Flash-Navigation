//
//  ResultView.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var viewModel: PlayViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(spacing: 48) {
            Spacer()
            
            Text("Congraturations!!")
                .font(.system(size: 80)).bold()
            
            scoresBox
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Close")
                    .capsuleButtonStyle()
                    .padding(.horizontal, 48)
            })
        }
        .padding(48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(NumbersBackground())
    }
}


//MARK: views
extension ResultView {
    private var scoresBox: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Scores")
                .font(.title.bold())
            
            Divider()
            
            VStack(spacing: 16) {
                Text("Answer")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(viewModel.answers.joinedWithArrow())
                    .font(.title.bold())
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                scoreCellBox(title: "Size", value: viewModel.count)
                scoreCellBox(title: "Digit", value: viewModel.digit)
            }
            
            HStack {
                scoreCellBox(title: "Replay Count", value: viewModel.replayCount)
                scoreCellBox(title: "Mistake Count", value: viewModel.mistakeCount)
                scoreCellBox(title: "Elapsed Time(s)", value: Int(viewModel.elapsedTime))
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 8))
    }
    
    @ViewBuilder
    private func scoreCellBox(title: String, value: Int) -> some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("\(value)")
                .font(.title.bold())
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ResultView(viewModel: PlayViewModel())
}
