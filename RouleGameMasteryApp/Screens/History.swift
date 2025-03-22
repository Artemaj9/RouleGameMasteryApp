//
//  History.swift
//  RouleGameMasteryApp
//
//  Created by Artem on 22.03.2025.
//

import SwiftUI

struct History: View {
  let radius: Double  = 30
    var body: some View {
      VStack(spacing: 0) {
        Color.green
          .height(200)
        
        UnevenRoundedRectangle(topLeadingRadius: radius, topTrailingRadius: radius)
          .fill(.blue.gradient)
          .padding(.top, -radius*2)
      }
      .ignoresSafeArea()
    }
}

#Preview {
    History()
}
