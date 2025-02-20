

import SwiftUI

struct NumbersBackground: View {
    let numbers = Array(1...100)
    
    @State private var number: Int = Int.random(in: 1...9) // 現在の数字
    @State private var positionY: CGFloat = -100
    @State private var opacity: Double = 1.0
    @State private var angle: Double = 0
    @State private var size: CGFloat = 120
    @State private var positionX: CGFloat = CGFloat.random(in: 50...UIScreen.main.bounds.width - 50)

    var body: some View {
        ZStack {
            Text("\(number)")
                .font(.system(size: size))
                .fontWeight(.bold)
                .foregroundColor(Color.primary.opacity(opacity))
                .rotationEffect(.degrees(angle))
                .position(x: positionX, y: positionY)
                .onAppear {
                    startFalling()
                }
        }
        .ignoresSafeArea()
    }
    
    private func startFalling() {
        positionY = -100
        opacity = 1.0
        positionX = CGFloat.random(in: 50...UIScreen.main.bounds.width - 50)
        size = CGFloat.random(in: 80...180)
        number = numbers.randomElement()!
        angle = Double.random(in: -180...180)

        withAnimation(.linear(duration: 5.0)) {
            positionY = UIScreen.main.bounds.height + 50
            opacity = 0.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            startFalling() // 5秒後にリセットして次の数字を降らせる
        }
    }
}

#Preview {
    NumbersBackground()
}
