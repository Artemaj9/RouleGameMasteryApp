//
//  Simulator.swift
//

import SwiftUI

struct Simulator: View {
  @EnvironmentObject var vm: GameViewModel
  @EnvironmentObject var nm: NavigationStateManager
  @State private var rouletteRotation: Double = 0
    @State private var ballRotation: Double = 0
  @State private var ballRadius: CGFloat = 0
    @State private var isSpinning = false
  
    var body: some View {
      ZStack {
        bg
        topSection
        ZStack {
         
          Image(.framewheel)
            .resizableToFit()
          Image(.wheel)
            .resizableToFit()
            .scaleEffect(0.82)
            
          //  .rotationEffect(.degrees(rouletteRotation))
            .rotationEffect(Angle(degrees: -vm.rotation))
            .animation(.snappy(duration: 4), value: vm.rotation)
         
          Image(.ball)
            .resizableToFit(height: 20)
            .offset(x: vm.currentRadius*cos(.pi * vm.currentAngle/180), y: vm.currentRadius*sin(.pi * vm.currentAngle/180))
           
           // .offset(x: ballRadius * cos(ballRotation * .pi / 180), y: ballRadius * sin(ballRotation * .pi / 180))
         
          
            Button {
              vm.rotation += Double(9.73 * Double(Int.random(in: 36...72))*6)
          } label: {
            Text("Start Rotation")
              .foregroundStyle(.white)
          }
          .background(.blue)
          .yOffset(vm.h*0.3)
        }
        
      }
      .onAppear {
        vm.setupRouleTimer()
        vm.rotation = Double(9.73*Double(Int.random(in: 27...36))) + 5
        
        
      //  ballRadius = vm.w*0.45
               // spinRoulette()
            }
    }
  
  private func spinRoulette() {
         isSpinning = true

         let duration = 5.0 // Adjust time for longer spins
         let finalRouletteRotation = Double(10 * Int.random(in: 54...90)) // Spins multiple times
let finalballRotation = Double(10 * Int.random(in: 54...90)*3)
    ballRadius = vm.w*0.45
         withAnimation(.easeOut(duration: duration)) {
           rouletteRotation += finalRouletteRotation
         }

         // Ball starts faster and slows down while moving inward
         withAnimation(.easeOut(duration: duration)) {
           ballRotation -= finalballRotation
         }
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//      withAnimation(.easeOut(duration: 2)) {
//        ballRadius = vm.w*0.3
//      }
   
 //   }
     }
  
  private var bg: some View {
    Image(.mbg)
      .backgroundFill()
  }
  private var topSection: some View {
    Rectangle()
      .fill(Color(hex: "720909"))
      .height(130)
      .overlay {
        ZStack {
          Text("Roulette Simulator")
            .rouleFont(size: 22, style: .interB, color: .white)
          HStack {
        
            Spacer()
            
            Button {
              if let calculation = vm.currentCalculation {
                vm.allCalculations.insert(calculation, at: 0)
                UserDefaultService.shared.saveStructs(structs: vm.allCalculations, forKey: UDKeys.calculations.rawValue)
              }
              vm.showCalculation = false
            } label: {
              Image(.xbtn)
                .resizableToFit(height: 40)
            }
           

          }
          .padding(.trailing)
        }
        .yOffset(24)
      }
      .yOffset(-vm.h*0.46)
  }
}

#Preview {
    Simulator()
    .vm
    .nm
}
