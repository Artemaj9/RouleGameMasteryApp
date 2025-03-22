//
//  BouncePhased.swift
//

import SwiftUI

struct BouncePhasedEffect: GeometryEffect {
  var height: CGFloat = 12
  var phase: CGFloat = 0
  
  var animatableData: CGFloat {
    get { phase }
    set { phase = newValue }
  }
  
  init(height: CGFloat = 12, phase: CGFloat) {
    self.height = height
    self.phase = CGFloat(phase)
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    ProjectionTransform(.init(translationX: height*bounceY(phase), y: 0))
  }
  
  private func bounceY(_ fi: CGFloat) -> CGFloat {
    abs(sin(fi))
  }
}

extension View {
  func bouncePhase(_ fi: Double) -> some View {
    modifier(BouncePhasedEffect(phase: fi))
  }
}
