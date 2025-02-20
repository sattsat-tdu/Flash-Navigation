//
//  Dialog.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

struct Dialog: Equatable {
    let title: String
    let message: String
    let systemImage: String?

    init(title: String, message: String, systemImage: String? = nil) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
    }

    static func == (lhs: Dialog, rhs: Dialog) -> Bool {
        return lhs.title == rhs.title &&
               lhs.message == rhs.message &&
               lhs.systemImage == rhs.systemImage
    }
}
