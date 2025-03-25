//
//  Font.swift
//

import SwiftUI

enum CustomFont: String {
  case interR = "Inter-Regular"
  case interM = "Inter-Medium"
  case interB = "Inter-Bold"
  case ibarraRealNova = "IbarraRealNova-Bold"
  case ibarraRealNovaSI = "IbarraRealNova-SemiBoldItalic"
  case cambayR = "Cambay-Regular"
  case cambayB = "Cambay-Bold"
  case scheherezade = "Scheherazade-Bold"
  
}

extension Font {
  static func custom(_ font: CustomFont, size: CGFloat) -> Font {
    Font.custom(font.rawValue, size: size)
  }
}
