//
//  DialogView.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

struct DialogView: View {
    
    @ObservedObject var appManager = AppManager.shared
    let dialog: Dialog
    
    private let width: CGFloat
    
    init(dialog: Dialog) {
        let size = UIScreen.main.bounds
        self.width = size.width * 0.85
        
        self.dialog = dialog
    }
    
    var body: some View {
        ZStack {
            Color.primary.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    appManager.dismissDialog()
                }
            
            VStack(spacing: 24) {
                if let systemImage = dialog.systemImage {
                    Image(systemName: systemImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .fontWeight(.bold)
                }

                Text(dialog.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)

                Text(dialog.message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("TAP TO CLOSE") {
                    appManager.dismissDialog()
                }
                .font(.title.bold())
                .foregroundStyle(.secondary)
                .padding(.top, 24)
            }
            .padding(24)
            .frame(width: width)
            .background()
            .cornerRadius(16)
            .shadow(radius: 2)
        }
    }
}

#Preview {
    DialogView(dialog: Dialog(
        title: "TItle",
        message: "Message detail,Message detail,Message detail,Message detail,Message detail",
        systemImage: "xmark"
    ))
}
