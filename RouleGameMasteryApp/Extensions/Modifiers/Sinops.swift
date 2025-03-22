//
//  Sinops.swift
//

import SwiftUI

struct Sinops: AnimatableModifier {
  var phase: CGFloat = 0
  
  var animatableData: CGFloat {
    get { phase }
    set { phase = newValue }
  }
  
  init(phase: CGFloat) {
    self.phase = phase
  }
  
  func body(content: Content) -> some View {
    content
      .opacity(sineOpacity(phase))
  }
  
  private func sineOpacity(_ phase: CGFloat) -> CGFloat {
    abs(sin(phase))
  }
}

extension View {
  func sineOps(_ phase: CGFloat) -> some View {
    modifier(Sinops(phase: phase))
  }
}
