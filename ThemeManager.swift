//
//  ThemeManager.swift
//  Dashboard
//
//  Created by User on 07.06.2024.
//

import Foundation

import SwiftUI


extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}


struct CustomColorScheme: Equatable {
    let primary: Color
    let secondary: Color
    let background: Color
    let text: Color
    
    static let light = CustomColorScheme(
        primary: Color(0xd2d2d2),
        secondary: Color(0x525252),
        background: Color(0xe1e1e1),
        text: Color(0x000000)
    )
    
    static let dark = CustomColorScheme(
        primary: Color(0x4c4c59),
        secondary: Color(0x292933),
        background: Color(0x484752),
        text: Color(0xFFFFFF)
    )
    
    static func ==(lhs: CustomColorScheme, rhs: CustomColorScheme) -> Bool {
            return lhs.primary == rhs.primary &&
                   lhs.secondary == rhs.secondary &&
                   lhs.background == rhs.background &&
                   lhs.text == rhs.text
        }
}


class ThemeManager: ObservableObject {
    @Published var currentScheme: CustomColorScheme = .light
    
    init(initialScheme: CustomColorScheme = .light) {
            self.currentScheme = initialScheme
        }
    
    func toggleTheme() {
        currentScheme = (currentScheme == .light) ? .dark : .light
    }
}
