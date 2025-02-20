//
//  AppManager.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import Foundation
import SwiftUI

@MainActor
final class AppManager: ObservableObject {
    static let shared = AppManager()
    
    @Published var dialog: Dialog?
    
    private init(){}
    
    func showDialog(dialog: Dialog) {
        self.dialog = dialog
    }
    
    func dismissDialog() {
        self.dialog = nil
    }
}
