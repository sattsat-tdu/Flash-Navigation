//
//  SwiftUIView.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/17
//  
//

import SwiftUI

struct FlashNumberView: View {
    
    let number: Int
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 400))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FlashNumberView(number: 10)
}
