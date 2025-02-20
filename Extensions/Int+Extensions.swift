//
//  Int+Extensions.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/19
//  
//

import SwiftUI

extension Int: @retroactive Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Int.self, contentType: .data)
    }
}
