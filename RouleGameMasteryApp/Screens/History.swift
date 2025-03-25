//
//  History.swift
//

import SwiftUI

struct History: View {
  @EnvironmentObject var nm: NavigationStateManager
  @EnvironmentObject var vm: GameViewModel
  @State private var selectedIndex = 0
  
  let radius: Double  = 30
    var body: some View {
      ZStack {
        Image(.mbg)
          .backgroundFill()
        if !vm.allCalculations.isEmpty {
          ScrollView {
            VStack(spacing: 16) {
              Color.clear.height(30)
              ForEach(vm.allCalculations.indices, id: \.self) { i in
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
                            Text(vm.percentString((vm.allCalculations[safe: i]?.success ?? 0)*100) + "%")
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
                            Text("\(vm.allCalculations[safe: i]?.win ?? 0)")
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
                            Text("\(vm.percentString(vm.allCalculations[safe: i]?.expectedReturn))")
                              .rouleFont(size: 17, style: .interB, color: .white)
                          }
                      }
                      .hPadding(40)
                    }
                    .padding(.bottom, 50)
                  }
                  .overlay(.top) {
                    Image(.statbg)
                      .resizableToFit()
                      .overlay(alignment: .top) {
                        Text("Your choice")
                          .rouleFont(size: 16, style: .interR, color: .white)
                          .padding(.top, 8)
                      }
                      .overlay {
                        choiceStats(i)
                          .padding(.top, 12)
                      }
                      .hPadding(8)
                      .vPadding(4)
                  }
                  .overlay(.topTrailing, content: {
                    Button {
                      selectedIndex = i
                      vm.showDeletePopUp = true
                    } label: {
                      Image(.bin)
                        .resizableToFit(height: 30)
                    }
                    .padding(.top, 14)
                    .padding(.trailing, 14)
                  })
                  .hPadding()
              }
              Color.clear.height(200)
            }
          }
          .yOffset(vm.h*0.12)
          .yOffset(vm.isSEight ? 12 : 0)
          .scrollIndicators(.hidden)
        } else {
          Text("No calculations yet")
            .rouleFont(size: 30, style: .interB, color: Color(hex: "#F3D9A5"))
        }
        
        
        topSection
        
        if vm.showDeletePopUp {
            CustomAlertView(
                title: "Delete",
                description: "Are you shure?"
                ,
                material: .thickMaterial,
                cancelAction: {

                    withAnimation {
                      vm.showDeletePopUp = false
                    }
                },
                cancelActionTitle: "Close",
                primaryAction: {
                  if   vm.allCalculations[safe: selectedIndex] != nil {
                    vm.allCalculations.remove(at: selectedIndex)
                    UserDefaultService.shared.saveStructs(structs: vm.allCalculations, forKey: UDKeys.calculations.rawValue)
                    withAnimation {
                      vm.showDeletePopUp = false
                    }
                  }
                },
                primaryActionTitle: "Delete"
            )
            .colorScheme(.dark)
        }
      }
      .navigationBarBackButtonHidden()
    }
  
  
  private func choiceStats( _ idx: Int) -> some View {
    HStack {
      VStack {
        Text("BET AMOUNT")
          .rouleFont(size: 14, style: .interR, color: .white)
        RoundedRectangle(cornerRadius: 12)
          .fill(.white)
          .frame(100, 35)
          .overlay {
            Text("\( vm.allCalculations[safe: idx]?.bet ?? 0)")
              .rouleFont(size: 16, style: .interB, color: .black)
          }
      }
      
      Spacer()
      
      VStack {
        Text("BALL LANDING PLACE")
          .rouleFont(size: 14, style: .interR, color: .white)
        RoundedRectangle(cornerRadius: 12)
          .fill(vm.blandStat[safe: vm.allCalculations[safe: idx]?.bland ?? 0]?.color ?? Color.red)
          .frame(100, 35)
          .overlay {
            Text(vm.blandStat[safe: vm.allCalculations[safe: idx]?.bland ?? 0]?.name ?? "")
              .rouleFont(size: 16, style: .interB, color: .white)
          }
      }
    }
    .hPadding(30)
    .padding(.top, 4)
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
      .yOffsetIf(vm.isSEight, 48)
  }
}

#Preview {
    History()
    .nm
    .vm
}
