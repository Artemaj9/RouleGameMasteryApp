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
  @State private var tableSize: CGSize = .zero
  @State private var stage = 1
  
  var body: some View {
    ZStack {
      bg
      
  
      wheel
        .yOffset(stage == 1 ? -vm.h*0.48 : 1)
        .opacity(stage == 1 ? 0.5 : 1)
        .animation(.easeInOut(duration: 0.7), value: stage)
      topSection
      stats
      maintable
    
      
      Button {
        stage = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          vm.setupRouleTimer()
        }
      } label: {
        Image(.spinwheelbtn)
          .resizableToFit()
        
      }
      .padding(.horizontal, vm.isSEight ? 20 : 0)
      .width(vm.w*0.7)
      .yOffset(vm.h*0.44)
      .transparentIfNot(stage == 1)
      .animation(.easeInOut(duration: 0.7), value: stage)
      .disabled(vm.bland == 8 && vm.selectedNumbers.count != 2)
      .opacity(vm.bland == 8 && vm.selectedNumbers.count != 2 ? 0.5 : 1)
      .yOffsetIf(vm.isSEight, -64)

      
      Button {
        withAnimation {
          stage = 1
        }
        vm.resetRoule()
      } label: {
        Image(.resetbtn)
          .resizableToFit(height: vm.isSEight ? 48 : 54)
      }
      .yOffset(vm.h*0.4)
      .transparentIfNot(stage == 2)
      .opacity(!vm.showPopUp ? 0 : 1)
      .disabled(!vm.showPopUp)
      .animation(.easeInOut(duration: 0.7), value: vm.showPopUp)
      .yOffsetIf(vm.isSEight, -48)
      ZStack {
        if vm.bland == 2 || vm.bland == 3 {
          Image(vm.currentNumber % 2 == 0 ? .eres : .ores)
            .resizableToFit(height: 200)
        } else {
          Image(vm.currentNumber == 0 ? .zres : (vm.currentColor == "Red" ? .rres : .bres))
            .resizableToFit(height: 200)
            .overlay(.trailing) {
              RoundedRectangle(cornerRadius: 6)
                .fill( Color(hex: vm.currentNumber == 0 ? "00BD3999" : (vm.currentColor == "Red" ? "C00000" : "0C0C0C")))
                .frame(56, 56)
                .overlay {
                  Text("\(vm.currentNumber)")
                    .rouleFont(size: 26, style: .interB, color: .white)
                }
                .padding(.trailing, 40)
            }
        }
      }
      .transparentIfNot(vm.showPopUp)
      .animation(.easeIn(duration: 0.7),value: vm.showPopUp)
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      vm.currentRadius = vm.w*0.45
    }
  }
  
  private var bg: some View {
    Image(.mbg)
      .backgroundFill()
  }
  
  private var wheel: some View {
    ZStack {
      Image(.framewheel)
        .resizableToFit()
      Image(.wheel)
        .resizableToFit()
        .scaleEffect(0.82)
        .rotationEffect(Angle(degrees: -vm.rotation))
        .animation(.snappy(duration: 4), value: vm.rotation)
      
      Image(.ball)
        .resizableToFit(height: 20)
        .offset(x: vm.currentRadius*cos(.pi * vm.currentAngle/180), y: vm.currentRadius*sin(.pi * vm.currentAngle/180))
    }
    .yOffsetIf(vm.isSEight, 36)
  }
  
  private var stats: some View {
    Image(.statsbg)
      .resizableToFit()
      .overlay {
        HStack(alignment: .top) {
          VStack(alignment: .leading) {
            HStack {
              Text("Total Spins")
                .rouleFont(size: 12, style: .interR, color: .white)
                .frame(width: 100, alignment: .leading)
              Text("\(vm.totalSpins)")
                .rouleFont(size: 12, style: .interB, color: .white)
            }
            HStack {
              Text("Total Wins")
                .rouleFont(size: 12, style: .interR, color: .white)
                .frame(width: 100, alignment: .leading)
              Text("\(vm.totalWins)")//*vm.bet*vm.blandStat[vm.currentCalculation?.bland ?? 0].coef)")
                .rouleFont(size: 12, style: .interB, color: .white)
            }
            
            HStack {
              Text("Actual Probability")
                .rouleFont(size: 12, style: .interR, color: .white)
                .frame(width: 100, alignment: .leading)
              Text("\(vm.percentString((vm.currentCalculation?.success ?? 0)))")
                .rouleFont(size: 12, style: .interB, color: .white)
            }
          }
          Spacer()
          VStack(alignment: .leading) {
            HStack {
              Text("Total Losses")
                .rouleFont(size: 12, style: .interR, color: .white)
                .frame(width: 100, alignment: .leading)
              Text("\(vm.totalSpins - vm.totalWins)")
                .rouleFont(size: 12, style: .interB, color: .white)
            }
            HStack {
              Text("Win Percentage")
                .rouleFont(size: 12, style: .interR, color: .white)
                .frame(width: 100, alignment: .leading)
              Text("\(vm.totalSpins != 0 ? vm.percentString( Double(vm.totalWins)/Double(vm.totalSpins)) : "0")")
                .rouleFont(size: 12, style: .interB, color: .white)
            }
          }
        }
        .hPadding()
        .padding(.top, 34)
      }
      .overlay(.top) {
        HStack {
          HStack {
            Text("Bet amount")
              .rouleFont(size: 12, style: .interR, color: .white)
            RoundedRectangle(cornerRadius: 8)
              .fill(.white)
              .frame(48, 24)
            
              .overlay {
                Text("\(vm.currentCalculation?.bet ?? 0)")
                  .rouleFont(size: 12, style: .interB, color: .black)
              }
              .padding(.trailing, 4)
          }
          
          Spacer()
          
          HStack {
            Text("Ball Landing Place")
              .rouleFont(size: 12, style: .interR, color: .white)
            RoundedRectangle(cornerRadius: 8)
              .fill(vm.blandStat[safe: vm.currentCalculation?.bland ?? 0]?.color ?? Color.red)
              .frame(48, 24)
            
              .overlay {
                Text(vm.blandStat[safe: vm.currentCalculation?.bland ?? 0]?.name ?? "")
                  .rouleFont(size: 12, style: .interB, color: .white)
              }
          }
        }
        .padding(.top, 12)
        .hPadding()
      }
      .hPadding(20)
      .yOffset(-vm.h*0.3)
      .yOffsetIf(vm.isSEight, 40)
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
              vm.showCalculation = false
              vm.resetRoule()
              vm.resetSimulations()
              nm.path = []
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
      .yOffsetIf(vm.isSEight, 50)
  }
  
  private var maintable: some View {
    VStack(spacing: -4) {
        ForEach(0..<12) { i in
          HStack(spacing: -4) {
            ForEach(0..<3) { j in
              Image(.cell)
                .resizableToFit(height: 38)
                .background {
                  
                  if vm.selectedNumbers.contains(3*i + j + 1) {
                    
                    Color(hex: "#FFEE85").opacity(0.5)
                    
                  }
                  
                }
                .overlay {
                  Image(vm.redNumbers.contains(3*i + j + 1) ? .redoval : .blackoval)
                    .resizableToFit(height: 24)
                }
                .overlay {
                  Text("\(3*i + j + 1)")
                    .rouleFont(size: 18, style: .scheherezade, color: .white)
                    .yOffset(2)
                }
                .overlay {
                  if vm.selectedNumbers.contains(3*i + j + 1) {
                    Image(.feature)
                      .resizableToFit(height: 21)
                      .offset(16, 12)
                  }
                }
                .onTapGesture {
                  if vm.canSelectNumbers() {
                    vm.handleSelection(for: 3*i + j + 1)
                  }
                }
            }
          }
        }
    }
    .readSize($tableSize)
    .overlay(.bottom) {
      HStack(spacing: -4) {
        ForEach(0..<3) { _ in
          Image(.cell)
            .resizableToFit(height: 38)
            .overlay {
              Text("2 to 1")
                .rouleFont(size: 21, style: .scheherezade, color: .white)
                .yOffset(2)
            }
            .yOffset(34)
        }
      }
      .transparentIf(vm.isSEight)
    }

    .overlay(.top) {
      Image(.nulbg)
        .resizableToFit(width: 224)
        .colorMultiply(!vm.selectedNumbers.contains(0) ? .white :   Color(hex: "#FFEE85").opacity(0.5))
        .overlay {
          if vm.selectedNumbers.contains(0) {
            Image(.feature)
              .resizableToFit(height: 21)
              .offset(20, 8)
          }
        }
        
        .overlay {
          Text("0")
            .rouleFont(size: 30, style: .scheherezade, color: .white)
        }
        .onTapGesture {
          if vm.bland == 7 {
            vm.handleSelection(for: 0)
          }
        }
        .yOffset(-44)
    }
    .overlay(alignment: .leading) {
      VStack(spacing: -4) {
        Image(.lines3)
          .resizableToFit()
            .background {
              if vm.bland == 4 {
                Color(hex: "#FFEE85").opacity(0.5)
              }
          }
            .overlay {
              ZStack {
                Image(.st12)
                  .resizableToFit(height: 54)
                if vm.bland == 4 {
                  Image(.feature)
                    .resizableToFit(height: 21)
                    .offset(16, 12)
                }
              }
            }
        Image(.lines3)
          .resizableToFit()
          .background {
            if vm.bland == 5 {
              Color(hex: "#FFEE85").opacity(0.5)
            }
        }
          .overlay {
            ZStack {
              Image(.nd24)
                .resizableToFit(height: 54)
              if vm.bland == 5 {
                Image(.feature)
                  .resizableToFit(height: 21)
                  .offset(16, 12)
              }
            }
          }
        Image(.lines3)
          .resizableToFit()
          .background {
            if vm.bland == 6 {
              Color(hex: "#FFEE85").opacity(0.5)
            }
        }
          .overlay {
            ZStack {
              Image(.rd12)
                .resizableToFit(height: 54)
              if vm.bland == 6 {
                Image(.feature)
                  .resizableToFit(height: 21)
                  .offset(16, 12)
              }
            }
          }
      }
      .xOffset(-62)
      .height(tableSize.height)
    }
    .overlay(alignment: .trailing) {
      VStack(spacing: -4) {
        Image(.lines2)
          .resizableToFit(height: 72)
          .overlay {
            Image(.to118)
              .resizableToFit(height: 44)
          }
        
        Image(.lines2)
          .resizableToFit(height: 72)
          .background {
            if vm.bland == 3 {
              Color(hex: "#FFEE85").opacity(0.5)
            }
          }
          .overlay {
            ZStack {
              Image(.even)
                .resizableToFit(height: 40)
              if vm.bland == 3 {
                Image(.feature)
                  .resizableToFit(height: 21)
                  .offset(16, 12)
              }
            }
          }
        Image(.lines2)
          .resizableToFit(height: 72)
          .background {
            if vm.bland == 0 {
              Color(hex: "#FFEE85").opacity(0.5)
            }
          }
          .overlay {
            ZStack {
              Image(.reds)
                .resizableToFit(height: 40)
              if vm.bland == 0 {
                Image(.feature)
                  .resizableToFit(height: 21)
                  .offset(16, 12)
              }
            }
          }
        
        Image(.lines2)
          .resizableToFit(height: 72)
          .background {
            if vm.bland == 1 {
              Color(hex: "#FFEE85").opacity(0.5)
            }
          }
          .overlay {
            ZStack {
              Image(.blacks)
                .resizableToFit(height: 40)
              if vm.bland == 1 {
                Image(.feature)
                  .resizableToFit(height: 21)
                  .offset(16, 12)
              }
            }
          }
        Image(.lines2)
          .resizableToFit(height: 72)
          .background {
            if vm.bland == 2 {
              Color(hex: "#FFEE85").opacity(0.5)
            }
          }
              .overlay {
                ZStack {
                  Image(.odds)
                    .resizableToFit(height: 40)
                  if vm.bland == 2 {
                    Image(.feature)
                      .resizableToFit(height: 21)
                      .offset(16, 12)
                  }
                }
              }
        Image(.lines2)
          .resizableToFit(height: 72)
          .overlay {
            Image(.t1936)
              .resizableToFit(height: 44)
          }
      }
      .xOffset(60)
      .height(tableSize.height)
    }
    .scaleEffect(vm.isSEight ? 0.9 : 1)
    .yOffset(vm.h*0.1)
    .opacity(stage == 1 ? 1 : 0.5)
    .yOffset(stage == 1 ? 0 : vm.h*0.48 )
    .yOffsetIf(vm.isSEight, -8)
    .animation(.easeInOut(duration: 0.7), value: stage)
  }
}

#Preview {
    Simulator()
    .vm
    .nm
}
