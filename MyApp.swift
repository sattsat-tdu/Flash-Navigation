




import SwiftUI

@main
struct MyApp: App {
    
    @ObservedObject private var appManager = AppManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .overlay() {
                    ZStack {
                        if let dialog = appManager.dialog {
                            DialogView(dialog: dialog)
                                .transition(.asymmetric(
                                    insertion: .scale(scale: 1.1).combined(with: .opacity),
                                    removal: .scale(scale: 1.0).combined(with: .opacity)
                                ))
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: appManager.dialog)
                }
        }
    }
}
