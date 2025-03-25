//
//  Calculate.swift
//

import SwiftUI

struct Calculate: View {
  @EnvironmentObject var vm: GameViewModel
  @EnvironmentObject var nm: NavigationStateManager
  
    var body: some View {
      ZStack {
        bg
        header
        
        Image(.calcdeskbg)
          .resizableToFit()
          .overlay(.bottom) {
            VStack {
              Text("Expected Return")
                .rouleFont(size: 14, style: .interR, color: .white)
                .padding(.bottom, 8)
              
              HStack {
                Text("Success Percentage")
                  .rouleFont(size: 16, style: .interM, color: .white)
                Spacer()
                Image(.dredbg)
                  .resizableToFit(height: 35)
                  .overlay {
                    Text(vm.percentString((vm.currentCalculation?.success ?? 0)*100) + "%")
                      .rouleFont(size: 17, style: .interB, color: .white)
                  }
              }
              .hPadding(40)
              
              HStack {
                Text("Win")
                  .rouleFont(size: 16, style: .interM, color: .white)
               
                Spacer()
                Image(.dredbg)
                  .resizableToFit(height: 35)
                  .overlay {
                    Text("\(vm.currentCalculation?.win ?? 0)")
                      .rouleFont(size: 17, style: .interB, color: .white)
                  }
              }
              .hPadding(40)
              
              HStack {
                Text("Expected Return\non your Bet")
                  .rouleFont(size: 16, style: .interM, color: .white)
                Spacer()
                Image(.dredbg)
                  .resizableToFit(height: 35)
                  .overlay {
                    Text("\(vm.percentString(vm.currentCalculation?.expectedReturn))")
                      .rouleFont(size: 17, style: .interB, color: .white)
                  }
              }
              .hPadding(40)
            }
            .padding(.bottom, vm.isSEight ? 32 : 50)
          }
          .overlay(.top) {
            Image(.statbg)
              .resizableToFit()
              .overlay(alignment: .top) {
                Text("Your choice")
                  .rouleFont(size: 16, style: .interR, color: .white)
                  .padding(.top, 4)
              }
              .overlay {
               choiceStats
              }
              .hPadding(8)
              .vPadding(4)
          }
          .hPadding()
          .yOffset(-vm.h*0.17)
          .yOffsetIf(vm.isSEight, 48)
        simBtn
          .yOffsetIf(vm.isSEight, 20)
      }
    }
  
  private var bg: some View {
    Image(.calcbg)
      .backgroundFill()
  }
  
  private var header: some View {
    ZStack {
      HStack {
        Text("Calculator answer")
          .rouleFont(size: 17, style: .interB, color: .white)
      }
  
      Button {
        if let calculation = vm.currentCalculation {
          vm.allCalculations.insert(calculation, at: 0)
          UserDefaultService.shared.saveStructs(structs: vm.allCalculations, forKey: UDKeys.calculations.rawValue)
        }
        vm.resetvm()
        vm.showCalculation = false
      } label: {
        Image(.xbtn)
          .resizableToFit(height: 40)
      }
      .xOffset(vm.w*0.4)
    }
    .yOffset(-vm.h*0.44)
    .yOffsetIf(vm.isSEight, 56)
  }
  
  private var simBtn: some View {
    Button {
      if let calculation = vm.currentCalculation {
        vm.allCalculations.insert(calculation, at: 0)
        UserDefaultService.shared.saveStructs(structs: vm.allCalculations, forKey: UDKeys.calculations.rawValue)
      }
      vm.updateDefaultSelection()
      nm.path.append(.simulation)
    } label: {
      Image(.testbetbtn)
        .resizableToFit()
    }
    .width(vm.w*0.7)
    .yOffset(vm.h*0.15)
  }
  
  private var choiceStats: some View {
    HStack {
      VStack {
        Text("BET AMOUNT")
          .rouleFont(size: 14, style: .interR, color: .white)
        RoundedRectangle(cornerRadius: 12)
          .fill(.white)
          .frame(100, 35)
          .overlay {
            Text("\( vm.currentCalculation?.bet ?? 0)")
              .rouleFont(size: 16, style: .interB, color: .black)
          }
      }
      
      Spacer()
      
      VStack {
        Text("BALL LANDING PLACE")
          .rouleFont(size: 14, style: .interR, color: .white)
        RoundedRectangle(cornerRadius: 12)
          .fill(vm.blandStat[safe: vm.currentCalculation?.bland ?? 0]?.color ?? Color.red)
          .frame(100, 35)
          .overlay {
            Text(vm.blandStat[safe: vm.currentCalculation?.bland ?? 0]?.name ?? "")
              .rouleFont(size: 16, style: .interB, color: .white)
          }
      }
    }
    .hPadding(30)
    .padding(.top, 4)
  }
}

#Preview {
    Calculate()
    .vm
    .nm
}
