//
//  NumberCell.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

struct NumberCell: View {
    
    let number: Int
    
    var body: some View {
        Rectangle()
            .fill(Color.orange)
            .frame(width: 80, height: 80)
            .overlay(
                Text("\(number)")
                    .font(.title.bold())
            )
            .clipShape(.rect(cornerRadius: 8))
            .shadow(radius: 2)
    }
}
