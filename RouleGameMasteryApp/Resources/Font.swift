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
  
}

extension Font {
  static func custom(_ font: CustomFont, size: CGFloat) -> Font {
    Font.custom(font.rawValue, size: size)
  }
}

//enum StyleText: String {
//  case interR, interM, interB,
//       ibarraRealNova,inarraRealNovaSI,
//       cambayR, cambayB
//}
//
