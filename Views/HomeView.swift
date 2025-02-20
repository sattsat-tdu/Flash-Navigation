//
//  HomeView.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

struct HomeView: View {
    
    @State private var playFlg = false
    
    @AppStorage(UserDefaultKeys.count.rawValue) private var count: Int = 5
    @AppStorage(UserDefaultKeys.digit.rawValue) private var digit: Int = 1

    private let countOptions = [5, 10, 15, 20]
    private let digitOptions = [1, 2, 3]
    
    var body: some View {
        VStack(spacing: 48) {
            Spacer()
            
            Text("Flash Navigation")
                .font(.system(size: 80)).bold()
            
            settingsBox
            
            Spacer()
            
            Button(action: {
                if digit == 1 && count > 5 {
                    AppManager.shared.showDialog(dialog: Dialog(
                        title: "Error",
                        message: "When the digit is 1, the count must be set to 5.",
                        systemImage: "xmark"
                    ))
                } else {
                    playFlg.toggle()
                }
            }, label: {
                Text("START")
                    .capsuleButtonStyle()
                    .padding(.horizontal, 48)
            })
        }
        .padding(48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(NumbersBackground())
        .fullScreenCover(isPresented: $playFlg) {
            PlayView()
        }
    }
}

extension HomeView {
    private var settingsBox: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Settings")
                .font(.title.bold())
            
            Divider()
            
            HStack {
                settingCellBox(
                    title: "Size",
                    subtitle: "Total values to sort. More values increase difficulty.",
                    value: $count,
                    options: countOptions
                )
                
                settingCellBox(
                    title: "Digit",
                    subtitle: "The difficulty increases as the number of digits increases.",
                    value: $digit,
                    options: digitOptions
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 8))
    }
    
    
    @ViewBuilder
    private func settingCellBox(
        title: String,
        subtitle: String,
        value: Binding<Int>,
        options: [Int]) -> some View {
        VStack(alignment: .center, spacing: 24) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(subtitle)
                .font(.headline)
                .foregroundStyle(.secondary)
                .frame(height: 56, alignment: .center)
            
            HStack(spacing: 12) {
                Button(action: {
                    if let currentIndex = options.firstIndex(of: value.wrappedValue), currentIndex > 0 {
                        value.wrappedValue = options[currentIndex - 1]
                    }
                }, label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                })
                .disabled(options.first == value.wrappedValue)
                
                Text("\(value.wrappedValue)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(minWidth: 60)
                
                Button(action: {
                    if let currentIndex = options.firstIndex(of: value.wrappedValue), currentIndex < options.count - 1 {
                        value.wrappedValue = options[currentIndex + 1]
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                })
                .disabled(options.last == value.wrappedValue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}

