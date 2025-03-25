//
//  MainView.swift
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var vm: GameViewModel
  @EnvironmentObject var nm: NavigationStateManager
  @State private var showPicker = false
  var body: some View {
    NavigationStack(path: $nm.path) {
      ZStack {
        bg
        header
        Image(.deskl)
          .resizableToFit()
          .overlay(.top) {
            Image(.betfield)
              .resizableToFit(height: vm.isSEight ? 50 : 54)
              .overlay(.trailing) {
                Image(.arrows)
                  .resizableToFit(height: 24)
                  .padding(.trailing)
              }
              .overlay {
                Text("\(vm.bet)")
                  .rouleFont(size: 17, style: .interM, color: .black)
              }
              .onTapGesture {
                if vm.bet == 0 {
                  vm.bet = 10
                }
                showPicker = true
              }
              .yOffset(vm.h*0.1)
          }
         
          .hPadding()
          .overlay {
            VStack {
              redblackrow
              bluerow
              greenrow
              yellowrow
              squareline
            }
            .scaleEffect(vm.isSEight ? 0.98 : 1)
            .overlay(alignment: .bottom) {
              calculatebtn
            }
            .yOffset(vm.h*0.05)
            .yOffsetIf(vm.isSEight, -24)
          }
          .yOffset(vm.h*0.05)
          .yOffsetIf(vm.isSEight, 24)
        
        if vm.showCalculation {
          Calculate()
        }
          
      }
      .onAppear {
        vm.resetvm()
      }
      .sheet(isPresented: $showPicker) {
        ZStack {
          VStack(spacing: 0) {
           
              Text("Bet Amount")
                .rouleFont(size: 20, style: .interB, color: .white)
                .foregroundStyle(.white)
           // }
            
            Picker("Select a Bet", selection: $vm.bet) {
              ForEach(0...1000, id: \.self) { number in
                Text("\(number)").tag(number)
                  .foregroundStyle(.white)
              }
            }
            .pickerStyle(.wheel)
            .frame(height: 180)
                
            okBtn
              .offset(y: vm.isSEight ? -24 : 0)
          }
        }
        .offset(y: 20)
        .vPadding()
        .presentationDetents([.fraction(vm.isSEight ? 0.4 : 0.33)])
        .background(BackgroundClearView(color: Color(hex: "808080").opacity(0.1)))
        .background(.ultraThinMaterial)
      }
      .navigationDestination(for: SelectionState.self) { state in
        if state == .info {
          Info()
        }
        
        if state == .history {
          History()
        }
        if state == .simulation {
          Simulator()
        }
        
        if state == .calculate {
          Calculate()
        }
      }
    }
  }
  
  private var okBtn: some View {
    Button {
      showPicker = false
    } label: {
      Image(.welcbtn)
        .resizableToFit(height: 44)
        .overlay {
          Text("Ok")
            .rouleFont(size: 17, style: .interB, color: Color(hex: "#020202"))
        }
    }

  }
  private var bg: some View {
    Image(.mbg)
      .backgroundFill()
  }
  
  private var header: some View {
    HStack(spacing: 8) {
      Button {
        nm.path.append(.info)
      } label: {
        Image(.infobtn)
          .resizableToFit(height: 48)
      }
      
      Spacer()

      Button {
        nm.path.append(.history)
      } label: {
        Image(.historybtn)
          .resizableToFit(height: 48)
      }
    }
    .hPadding(24)
    .yOffset(-vm.h*0.42)
    .yOffsetIf(vm.isSEight, 44)
  }
    
  private var redblackrow: some View {
    HStack {
      Button {
        vm.bland = 0
      } label: {
        Image(.redb)
          .resizableToFit(height: 46)
      }
      .opacity(vm.bland == nil || vm.bland == 0 ? 1 : 0.5)
      
      Button {
        vm.bland = 1
      } label: {
        Image(.blackb)
          .resizableToFit(height: 49)
      }
      .opacity(vm.bland == nil || vm.bland == 1 ? 1 : 0.5)
    }
  }
  
  private var bluerow: some View {
    HStack {
      Button {
        vm.bland = 2
      } label: {
        Image(.oddsb)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 2 ? 1 : 0.5)
      
      Button {
        vm.bland = 3
      } label: {
        Image(.evensb)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 3 ? 1 : 0.5)
    }
  }
    private var greenrow: some View {
      HStack {
        Button {
          vm.bland = 4
        } label: {
          Image(.b12)
            .resizableToFit(height: 48)
        }
        .opacity(vm.bland == nil || vm.bland == 4 ? 1 : 0.5)
        
        Button {
          vm.bland = 5
        } label: {
          Image(.b24)
            .resizableToFit(height: 48)
        }
        .opacity(vm.bland == nil || vm.bland == 5 ? 1 : 0.5)
        
        
        Button {
          vm.bland = 6
        } label: {
          Image(.b36)
            .resizableToFit(height: 48)
        }
        .opacity(vm.bland == nil || vm.bland == 6 ? 1 : 0.5)
      }
    }
   
  
  private var yellowrow: some View {
    HStack {
      Button {
        vm.bland = 7
        
      } label: {
        Image(.bstraight)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 7 ? 1 : 0.5)
      
      Button {
        vm.bland = 8
      } label: {
        Image(.bsplit)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 8 ? 1 : 0.5)
      
      
      Button {
        vm.bland = 9
      } label: {
        Image(.bstreet)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 9 ? 1 : 0.5)
    }
  }
  
  private var squareline: some View {
    HStack {
      Button {
        vm.bland = 10
      } label: {
        Image(.bsquare)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 10 ? 1 : 0.5)
      
      Button {
        vm.bland = 11
      } label: {
        Image(.bsix)
          .resizableToFit(height: 48)
      }
      .opacity(vm.bland == nil || vm.bland == 11 ? 1 : 0.5)
    }
    .frame(width: vm.w*0.8)
  }
  
  private var calculatebtn: some View {
    Button {
      vm.currentCalculation =
      Calculation(
        bet: vm.bet,
        bland: vm.bland ?? 0,
        success: vm.blandStat[vm.bland ?? 0].0,
        win: vm.bet*vm.blandStat[vm.bland ?? 0].coef,
        expectedReturn: Double(vm.bet)*(vm.blandStat[vm.bland ?? 0].0*2 - 1)
      )
      
      withAnimation {
        vm.showCalculation = true
      }
    } label: {
      Image(.calculatebtn)
        .resizableToFit(width: vm.w*0.75)
    }
    .opacity(vm.bland == nil || vm.bet == 0 ? 0.5 : 1)
    .disabled(vm.bland == nil || vm.bet == 0)
    .yOffset(vm.h*0.12)
    .animation(.easeInOut, value: vm.bland == nil || vm.bet == 0)
    .yOffsetIf(vm.isSEight, -20)
  }
}

#Preview {
  MainView()
    .vm
    .nm
}
