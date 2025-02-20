//
//  Array+Extensions.swift
//  FlashNavigation
//  
//  Created by SATTSAT on 2025/02/20
//  
//

extension Array where Element: CustomStringConvertible {
    func joinedWithArrow() -> String {
        self.map { "\($0)" }.joined(separator: " → ")
    }
}
