//
//  Extensions+View.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

extension View {
    @ViewBuilder
    func ifLet<T>(_ value: T?, transform: (Self, T) -> some View) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
    
    func capsuleButtonStyle() -> some View {
        self
            .font(.headline)
            .foregroundColor(.black)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color.yellow)
            .clipShape(Capsule())
    }
}
