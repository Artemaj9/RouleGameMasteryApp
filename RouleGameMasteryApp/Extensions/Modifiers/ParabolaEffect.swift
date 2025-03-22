//
//  ParabolaEffect.swift
//

import SwiftUI

struct ParabolaEffect: GeometryEffect {
  var x: CGFloat = 0
  
  var animatableData: CGFloat {
    get { x }
    set { x = newValue }
  }

  func effectValue(size: CGSize) -> ProjectionTransform {
    ProjectionTransform(.init(translationX: x, y: fx(x)))
  }
  
  private func fx(_ x: CGFloat) -> CGFloat {
    x*x*0.004
  }
}

extension View {
  func parabolaMove(_ x: CGFloat) -> some View {
    modifier(ParabolaEffect(x: x))
  }
}
