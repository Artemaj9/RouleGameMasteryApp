//
//  Bounce.swift
//

import SwiftUI

struct BounceEffect: GeometryEffect {
  var height: CGFloat = 20
  var times: CGFloat = 0
  
  var animatableData: CGFloat {
    get { times }
    set { times = newValue }
  }
  
  init(height: CGFloat = 20, times: Int) {
    self.height = height
    self.times = CGFloat(times)
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    ProjectionTransform(.init(translationX: height*bounceY(times), y: 0))
  }
  
  private func bounceY(_ x: CGFloat) -> CGFloat {
    (sin(x * .pi))
  }
}

extension View {
  func bounce(_ n: Int) -> some View {
    modifier(BounceEffect(times: n))
  }
}
