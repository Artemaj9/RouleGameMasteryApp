//
//  Info.swift
//

import SwiftUI

struct Info: View {
  @EnvironmentObject var vm: GameViewModel
  @EnvironmentObject var nm: NavigationStateManager
    var body: some View {
      ZStack {
        bg
      
        ScrollView {
          VStack(alignment: .leading) {
            Color.clear.height(50)
            
            Text(Txt.infoDescr)
              .rouleFont(size: 17, style: .interR, color: .white)
             
              .multilineTextAlignment(.leading)
              .padding(.bottom)
           
              ForEach(0..<4) { t in
                HStack(alignment: .firstTextBaseline) {
                  Text(Txt.dot)
                  Text(Txt.infoList1[t])
                    .padding(.bottom, 4)
                  
                }
                .hPadding(8)
                .rouleFont(size: 17, style: .interR, color: .white)
              }
            
       
          
            Text("1) Betting probability calculator")
              .rouleFont(size: 21, style: .interB, color: .white)
             .padding(.top)
            
            Text("Data entry")
              .rouleFont(size: 21, style: .interB, color: .white)
              .padding(.bottom)
            ForEach(0..<5) { n in
              HStack(alignment: .firstTextBaseline) {
                Text("\(n+1).")
                Text(Txt.infoListNum[n])
                  .padding(.bottom, 4)
              }
              .rouleFont(size: 17, style: .interR, color: .white)
              .hPadding(8)
            }
            
            ForEach(0..<5) { t in
              HStack(alignment: .firstTextBaseline) {
                Text(Txt.dot)
                Text(Txt.infoList2[t])
                  .padding(.bottom, 4)
              }
              .rouleFont(size: 17, style: .interR, color: .white)
              .hPadding(30)
            }
            
            Text("Calculation of Probabilities")
              .rouleFont(size: 21, style: .interB, color: .white)
              .padding(.vertical)
            
           
            
            Text("Outcome Probability")
              .rouleFont(size: 21, style: .interB, color: Color(hex: "FFEE85"))
            Image(.f1)
              .resizableToFit(height: 42)
              .frame(maxWidth: .infinity, alignment: .center)
              .padding(.vertical, 12)
          
            
            Text("Success Percentage")
              .rouleFont(size: 21, style: .interB, color: Color(hex: "FFEE85"))
            Image(.f2)
              .resizableToFit(height: 25)
              .frame(maxWidth: .infinity, alignment: .center)
              .padding(.vertical, 12)
            
            
            Text("Expected Return on Bet")
              .rouleFont(size: 21, style: .interB, color: Color(hex: "FFEE85"))
            Image(.f3)
              .resizableToFit()
              .hPadding()
              .frame(maxWidth: .infinity, alignment: .center)
              .padding(.vertical, 12)
            
            Text("2) Roulette Simulator")
              .rouleFont(size: 21, style: .interB, color: .white)
             .padding(.top)
            
            Text("The user can test strategies by spinning a virtual roulette wheel. After each spin the results are recorded:")
              .rouleFont(size: 17, style: .interR, color: .white)
              .padding(.top, 8)
          
            HStack(alignment: .firstTextBaseline) {
              Text(Txt.dot)
                .rouleFont(size: 17, style: .interB, color: .white)
              
              Text("Total Spins")
                .foregroundColor(.white)
                .font(.custom(.interB, size: 17))
              +
              Text("- the number of times a bet has been played")
                .foregroundColor(.white)
                .font(.custom(.interR, size: 17))
               
            }
            .padding(.top, 8)
            .hPadding(8)
            
            
            HStack(alignment: .firstTextBaseline) {
              Text(Txt.dot)
                .rouleFont(size: 17, style: .interB, color: .white)
              
              Text("Total Wins")
                .foregroundColor(.white)
                .font(.custom(.interB, size: 17))
              +
              Text(" - how many bets were played")
                .foregroundColor(.white)
                .font(.custom(.interR, size: 17))
               
            }
            .padding(.top, 8)
            .hPadding(8)
            
            HStack(alignment: .firstTextBaseline) {
              Text(Txt.dot)
                .rouleFont(size: 17, style: .interB, color: Color(hex: "FFEE85"))
              
              Text("Total Losses")
                .foregroundColor(Color(hex: "FFEE85"))
                .font(.custom(.interB, size: 17))
               
            }
            .padding(.top, 8)
            .hPadding(8)
            
            Image(.f4)
              .resizableToFit(height: 25)
              .frame(maxWidth: .infinity, alignment: .center)
            
            
            HStack(alignment: .firstTextBaseline) {
              Text(Txt.dot)
                .rouleFont(size: 17, style: .interB, color: Color(hex: "FFEE85"))
              
              Text("Win Percentage")
                .foregroundColor(Color(hex: "FFEE85"))
                .font(.custom(.interB, size: 17))
               
            }
            .padding(.top, 8)
            .hPadding(8)
            
            Image(.f5)
              .resizableToFit(height: 42)
              .frame(maxWidth: .infinity, alignment: .center)
            
            Text("3) The difference between theory and reality")
              .rouleFont(size: 21, style: .interB, color: .white)
             .padding(.top)
            
            Text("The user can test strategies by spinning a virtual roulette wheel. After each spin the results are recorded:")
              .rouleFont(size: 17, style: .interR, color: .white)
              .padding(.top, 8)
            
            Image(.f6)
              .resizableToFit(height: 21)
              .padding(.vertical)
              .frame(maxWidth: .infinity)
              .padding(.vertical)
            
            HStack(alignment: .firstTextBaseline) {
              Text(Txt.dot)
                .rouleFont(size: 17, style: .interB, color: .white)
              
              Text("Win Percentage")
                .foregroundColor(.white)
                .font(.custom(.interB, size: 17))
               
            }
            .padding(.top, 8)
            .hPadding(8)
            
            Image(.f7)
              .resizableToFit(height: 42)
              .frame(maxWidth: .infinity, alignment: .center)
            
            Color.clear.height(300)
          }
          .hPadding()
        }
        .scrollIndicators(.hidden)
        .scrollMask(location1: 0, location2: 0.05, location3: 0.75, location4: 0.9)
        .yOffset(vm.h*0.12)
        
        topSection
      }
      .ignoresSafeArea()
      .navigationBarBackButtonHidden()
    }
  
  private var bg: some View {
    Color(hex: "850E0E")
      .ignoresSafeArea()
  }
  
  private var topSection: some View {
    Rectangle()
      .fill(Color(hex: "720909"))
      .height(130)
      .overlay {
        ZStack {
          Text("App Info")
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
    Info()
    .vm
    .nm
}
