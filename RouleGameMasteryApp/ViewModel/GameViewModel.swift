//
//  GameViewModel.swift
//
// swiftlint:disable all

import SwiftUI
import Combine
import CoreImage.CIFilterBuiltins

final class GameViewModel: ObservableObject {
  @Published var size: CGSize = CGSize(width: 393, height: 851)
  @Published var isSplash = true
  @Published var isWelcome = true
  
  // CORE IMAGE
  let welcbg = CIImage(image: UIImage(named: "welcroulebg")!)!
  let context = CIContext()
  let distwirlFilter: CIFilter = CIFilter.twirlDistortion()
  @Published var filteredImage: UIImage = UIImage(named: "welcroulebg")!
  
  @Published var radius: Float = 500
  @Published var angle: Float = 3
  @Published var showDeletePopUp = false
  
  func twirlDistort() {
    let filter = CIFilter.twirlDistortion()
    filter.inputImage = welcbg
    filter.radius = radius
    filter.angle = angle
    filter.center = CGPoint(x: 291, y: 744)
    let twirlimage = filter.outputImage!
    if let cgimg = context.createCGImage(twirlimage, from: CGRect(x: 0, y: 0, width: 720, height: 1280)) {
      self.filteredImage = UIImage(cgImage: cgimg)
    }
  }
  
  // MARK: CORE
  @Published var bland: Int? = 2
  @Published var bet: Int = 0
  @Published var showCalculation = false
  @Published var currentCalculation: Calculation? = Calculation(
    bet: 10,
    bland: 3,
    success: 32.45,
    win: 45,
    expectedReturn: -50
  )
  
  @Published var allCalculations: [Calculation] = []
  @Published var rotation: Double = 0
  
  
  let blandStat: [(Double, coef: Int, color: Color, name: String)] = [
    (0.4864, coef: 2, color: Color(hex: "FF0000"), name: "Red"),
    (0.4864, coef: 2, color: Color(hex: "000000"), name: "Black"),
    (0.4864, coef: 2, color: Color(hex: "0073A8"), name: "Odds"),
    (0.4864, coef: 2, color: Color(hex: "0073A8"), name: "Evens"),
    (0.3243, coef: 3, color: Color(hex: "3DB325"), name: "1-12"),
    (0.3243, coef: 3, color: Color(hex: "3DB325"), name: "13-24"),
    (0.3243, coef: 3 ,color: Color(hex: "3DB325"), name: "25-36"),
    (0.0270, coef: 35, color: Color(hex: "E5A71F"), name: "Straight"),
    (0.0541, coef: 17, color: Color(hex: "E5A71F"), name: "Split"),
    (0.0811, coef: 11, color: Color(hex: "E5A71F"), name: "Street"),
    (0.1081, coef: 8, color: Color(hex: "E5A71F"), name: "Square"),
    (0.1620, coef: 5, color: Color(hex: "E5A71F"), name: "Six Line")
  ]
  
  let rouletteNumbers = [
      21, 2, 25, 17, 34, 6, 27, 13, 36, 11,
      30, 8, 23, 10, 5, 24, 16, 33, 1, 20,
      14, 31, 9, 22, 18, 29, 7, 28, 12, 35,
      3, 26, 0, 32, 15, 19, 4
  ]
  
  
  let redNumbers: Set<Int> = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19,
                              21, 23, 25, 27, 30, 32, 34, 36]

  @Published var time = 0
  
  
  // SimulationStats
  @Published var totalSpins = 0
  @Published var totalWins = 0
  
  @Published  var selectedNumbers: Set<Int> = []
  @Published var currentBet: BetType = .straight(1)
  @Published var showResetBtn = false
  

  private var cancellables = Set<AnyCancellable>()
  
  init() {
    allCalculations = UserDefaultService.shared.getStructs(forKey: UDKeys.calculations.rawValue) ?? []
  }
  
  
 func canSelectNumbers() -> Bool {
    switch bland {
       case 7, 8, 9, 10, 11:
           return true
       default:
           return false
       }
   }
  
 func handleSelection(for number: Int) {
    switch bland {
      case 7:
          selectedNumbers = [number]
          currentBet = .straight(number)
          
      case 8:
          if selectedNumbers.count == 1 {
              let first = selectedNumbers.first!
              if isValidSplit(first, number) {
                  selectedNumbers.insert(number)
                  currentBet = .split(first, number)
              }
          } else {
              selectedNumbers = [number]
          }

      case 9:
          let rowStart = number - (number - 1) % 3
          selectedNumbers = [rowStart, rowStart + 1, rowStart + 2]
          currentBet = .street(Array(selectedNumbers))

      case 10:
          let col = (number - 1) % 3
          let row = (number - 1) / 3
          if col < 2 && row < 11 {
              selectedNumbers = [number, number + 1, number + 3, number + 4]
             
          } else if col == 2 && row < 11 {
            selectedNumbers = [number - 1, number, number + 2, number + 3]
         }
         else if col < 2 && row == 11 {
           selectedNumbers = [number - 3, number - 2, number, number + 1]
         }
         else {
           selectedNumbers = [number - 4, number - 3, number - 1, number]
         }
      currentBet = .square(Array(selectedNumbers))

      case 11:
          let rowStart = number - (number - 1) % 3
          if rowStart < 34 {
              selectedNumbers = [rowStart, rowStart + 1, rowStart + 2, rowStart + 3, rowStart + 4, rowStart + 5]
              currentBet = .sixLine(Array(selectedNumbers))
          }

      default:
          break
      }
  }
  
 func isValidSplit(_ first: Int, _ second: Int) -> Bool {
         let adjacentOffsets = [1, 3]
         return adjacentOffsets.contains(abs(first - second))
     }

  func resetvm() {
    bland = nil
    bet = 0
    resetRoule()
    selectedNumbers = []
    rotation = 0
    showPopUp = false
    showDeletePopUp = false
    showResetBtn = false
  }
  
  @Published var omega = 9.73*Double(Int.random(in:(27...36)))
  @Published var currentAngle: Double = 0
  @Published var rouleTime: Double = 0
  @Published var startRadius: Double = 0
  @Published var endRadius: Double = 0
  @Published var currentRadius: Double = 0
  let spinTime: Double = 4
  
  func resetRoule() {
    omega = 9.73*Double(Int.random(in:(27...36)))
    currentAngle = 0
    rouleTime = 0
    startRadius = w*0.45
    endRadius = w*0.3
    endRadius = 0
    currentRadius = w*0.45
    showPopUp = false
    rotation = 0
  }
  
  func resetSimulations() {
    totalSpins = 0
    totalWins = 0
  }
  
  let allNumbers = Array(1...36)
  func updateDefaultSelection() {
    switch bland {
        case 7:
            selectedNumbers = [allNumbers.randomElement() ?? 1]

        case 8:
            let first = allNumbers.randomElement() ?? 1
            let second = [first + 1, first + 3].filter { allNumbers.contains($0) }.randomElement() ?? first
            selectedNumbers = [first, second]

        case 9:
            let rowStart = [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34].randomElement() ?? 1
            selectedNumbers = [rowStart, rowStart + 1, rowStart + 2]

        case 10:
            selectedNumbers = [1, 2, 4, 5]

        case 11:
            let rowStart = [1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31].randomElement() ?? 1
            selectedNumbers = [rowStart, rowStart + 1, rowStart + 2, rowStart + 3, rowStart + 4, rowStart + 5]

        default:
            selectedNumbers.removeAll()
        }
    }
  
  @Published var isWin = false
  @Published var showPopUp = false
  @Published var currentNumber = 0
  @Published var currentColor: String = "Red"
  func setupRouleTimer() {
    resetRoule()
   // rotation = 0
    let phi = Double(omega)*spinTime/2
    let beta = 2*phi/(spinTime*spinTime)
    rotation = Double(9.73*Double(Int.random(in: 27...36))) + 5
    startRadius = w*0.45
    endRadius = w*0.3
    currentRadius = startRadius
    currentNumber = findRouletteNumber(phi: phi, rotation: rotation).number
    currentColor = findRouletteNumber(phi: phi, rotation: rotation).color
    print("Number is: \(findRouletteNumber(phi: phi, rotation: rotation).number)")
    print("Color is: \(findRouletteNumber(phi: phi, rotation: rotation).color)")
    
    Timer
      .publish(every: 0.01, on: .main, in: .common)
      .autoconnect()
      .sink { [unowned self] _ in
        if rouleTime < 4 {
          rouleTime += 0.01
          currentAngle = Double(omega)*rouleTime - pow(rouleTime, 2)*beta / 2
          currentRadius = (1 - pow(max(0, rouleTime/2 - 1), 0.5)) * startRadius +  pow(max(0, rouleTime/2 - 1), 0.5)*endRadius
        } else {
          showPopUp = true
          isWin = checkWinningBet(bet: getBetType(from: bland ?? 0, selectedNumbers: selectedNumbers), result: findRouletteNumber(phi: phi, rotation: rotation).number)
          if isWin  {
            totalWins += 1
          }
          totalSpins += 1
          for item in cancellables {
            item.cancel()
          }
        }
      }
      .store(in: &cancellables)
  }
  
  func findRouletteNumber(phi: Double, rotation: Double) -> (number: Int, color: String) {
      let sectionAngle = 360.0 / 37.0
      let finalAngle = (phi + rotation).truncatingRemainder(dividingBy: 360)
      let normalizedAngle = finalAngle < 0 ? finalAngle + 360 : finalAngle
      let index = Int(round(normalizedAngle / sectionAngle)) % 37
      let landedNumber = rouletteNumbers[index]
      return (landedNumber, getColor(for: landedNumber))
  }
  
  func getColor(for number: Int) -> String {
      if number == 0 {
          return "Green"
      }
      return redNumbers.contains(number) ? "Red" : "Black"
  }
  
  func setupTwirlTimer() {
    Timer
      .publish(every: 0.1, on: .main, in: .common)
      .autoconnect()
      .sink { [unowned self] _ in
        angle += 3/4
        radius -= 5
        if radius <= 50 {
          for item in cancellables {
            item.cancel()
          }
        }
        twirlDistort()
      }
      .store(in: &cancellables)
  }
  
  func percentString(_ number: Double?) -> String {
    String(format: "%.2f", number ?? 0)
  }
  
  func getBetType(from number: Int, selectedNumbers: Set<Int>) -> BetType {
      switch number {
      case 0:
          return .red
      case 1:
          return .black
      case 2:
          return .odd
      case 3:
          return .even
      case 4:
          return .low(1...12)
      case 5:
          return .low(13...24)
      case 6:
          return .low(25...36)
      case 7:
          if let single = selectedNumbers.first {
              return .straight(single)
          }
      case 8:
          if selectedNumbers.count == 2 {
              let numbers = Array(selectedNumbers)
              return .split(numbers[0], numbers[1])
          }
      case 9:
          if selectedNumbers.count == 3 {
              return .street(Array(selectedNumbers))
          }
      case 10:
          if selectedNumbers.count == 4 {
              return .square(Array(selectedNumbers))
          }
      case 11:
          if selectedNumbers.count == 6 {
              return .sixLine(Array(selectedNumbers))
          }
      default:
          return .red
      }

      return .red
  }
  
  func checkWinningBet(bet: BetType, result: Int) -> Bool {
      switch bet {
      case .red:
          return getColor(for: result) == "Red"
      case .black:
          return getColor(for: result) == "Black"
      case .odd:
          return result != 0 && result % 2 != 0
      case .even:
          return result != 0 && result % 2 == 0
      case .low(let range): // 1-12, 13-24, 25-36
          return range.contains(result)
      case .straight(let number):
          return result == number
      case .split(let n1, let n2):
          return result == n1 || result == n2
      case .street(let numbers):
          return numbers.contains(result)
      case .square(let numbers):
          return numbers.contains(result)
      case .sixLine(let numbers):
          return numbers.contains(result)
      }
  }
  
  // MARK: - Layout
  
  var h: CGFloat {
    size.height
  }
  
  var w: CGFloat {
    size.width
  }
  
  var isEightPlus: Bool {
    return size.width > 405 && size.height < 910 && size.height > 880 && UIDevice.current.name != "iPhone 11 Pro Max"
  }
  
  var isElevenProMax: Bool {
    UIDevice.current.name == "iPhone 11 Pro Max"
  }
  
  var isIpad: Bool {
    UIDevice.current.name.contains("iPad")
  }
  
  var isSE: Bool {
    return size.width < 380
  }
  
  var isSEight: Bool {
    return isSE || isEightPlus
  }
}


