//
//  History.swift
//

import SwiftUI

struct History: View {
  @EnvironmentObject var nm: NavigationStateManager
  @EnvironmentObject var vm: GameViewModel
  
  let radius: Double  = 30
    var body: some View {
      ZStack {
      
        Image(.mbg)
          .backgroundFill()
        topSection
      }
      .navigationBarBackButtonHidden()
    }
  
  private var topSection: some View {
    Rectangle()
      .fill(Color(hex: "720909"))
      .height(130)
      .overlay {
        ZStack {
          Text("Calculation History")
            .rouleFont(size: 22, style: .interB, color: .white)
          HStack {
            Button {
              nm.path = []
            } label: {
              HStack {
                Image(.arrow)
                  .resizableToFit(height: 20)
                
                Text("Back")
                  .rouleFont(size: 17, style: .interR, color: .white)
              }
            }
            
            Spacer()
          }
          .padding(.leading)
        }
        .yOffset(24)
      }
      .yOffset(-vm.h*0.46)
  }
}

#Preview {
    History()
    .nm
    .vm
}
