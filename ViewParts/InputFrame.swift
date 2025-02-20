//
//  InputFrame.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

struct InputFrame: View {
    
    let number: Int?
    
    var body: some View {
        if let number = number {
            NumberCell(number: number)
        } else {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 8))
                .shadow(radius: 2)
        }
    }
}
