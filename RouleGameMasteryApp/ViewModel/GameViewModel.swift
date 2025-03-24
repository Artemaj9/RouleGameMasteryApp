//
//  GameViewModel.swift
//
// swiftlint:disable all

import SwiftUI
import Combine
//import CoreImage
import CoreImage.CIFilterBuiltins

final class GameViewModel: ObservableObject {
  @Published var size: CGSize = CGSize(width: 393, height: 851)
  @Published var isSplash = true
  @Published var isTestResult = false
  @Published var isWelcome = true
  
  // CORE IMAGE
  let welcbg = CIImage(image: UIImage(named: "welcroulebg")!)!
  let context = CIContext()
  let distwirlFilter: CIFilter = CIFilter.twirlDistortion()
  @Published var filteredImage: UIImage = UIImage(named: "welcroulebg")!
  
  @Published var radius: Float = 500
  @Published var angle: Float = 3
  
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
  @Published var bland: Int? = nil
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
    (0.4864, coef: 2, color: Color(hex: "FF0000"), name: "Black"),
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
  
  
  // Roullete
  @Published var time = 0
  
 
  // MARK: GAME
  @Published var records = [0, 0, 0, 0, 0]
  @AppStorage("bestscore") var bestScore = 0
  @AppStorage("balance") var balance = 300
  @AppStorage("hints") var hints = 3
  @AppStorage("currentStatus") var currentStatus = 1
  @Published var currentGameLevel = 1
  
  @Published var isWin = false
  @Published var isLose = false
  
  // MARK: GAMEPLAY
  @Published var currentQuestion = 1
  @Published var gameBalance = 0
  @Published var rightAnswer = 1
  @Published var currentSelection = 0
  
  // MARK: - Loading
  @Published var isLoading = false
  @Published var aivmisLoad = false
  @Published var percent = 0
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    allCalculations = UserDefaultService.shared.getStructs(forKey: UDKeys.calculations.rawValue) ?? []
  }

  func resetvm() {
    cancelLoadingTimer()
    percent = 0
    isLoading = false
    aivmisLoad = false
    isTestResult = false
    isWin = false
    isLose = false
    gameBalance = 0
    currentSelection = 0
    currentQuestion = 1
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
    startRadius = 0
    endRadius = 0
    currentRadius = 0
  }
  
  func setupRouleTimer() {
    resetRoule()
    let phi = Double(omega)*spinTime/2
    let beta = 2*phi/(spinTime*spinTime)
    startRadius = w*0.45
    endRadius = w*0.3
    currentRadius = startRadius
    cancelLoadingTimer()
    
    Timer
      .publish(every: 0.01, on: .main, in: .common)
      .autoconnect()
      .sink { [unowned self] _ in
        if rouleTime < 4 {
          rouleTime += 0.01
          currentAngle = Double(omega)*rouleTime - pow(rouleTime, 2)*beta / 2
          currentRadius = (1 - pow(max(0, rouleTime/2 - 1), 0.5)) * startRadius +  pow(max(0, rouleTime/2 - 1), 0.5)*endRadius
        } else {
          for item in cancellables {
            item.cancel()
          }
        }
      }
      .store(in: &cancellables)
  }
  
  func setupTwirlTimer() {
    cancelLoadingTimer()
    percent = 0
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
        print("Radius :\(radius)")
        twirlDistort()
      }
      .store(in: &cancellables)
  }
  
  func percentString(_ number: Double?) -> String {
    String(format: "%.2f", number ?? 0)
  }
  
  func setupLoadingTimer() {
    cancelLoadingTimer()
    percent = 0
    Timer
      .publish(every: 0.1, on: .main, in: .common)
      .autoconnect()
      .sink { [unowned self] _ in
        if isLoading {
          if percent < 100 {
            if aivmisLoad {
              percent += min(3, 100 - percent)
            } else {
              if percent < 50 {
                percent +=  min(Int.random(in: 0...3), 100 - percent)
              } else if percent < 80 {
                percent +=  min(Int.random(in: 0...1), 100 - percent)
              } else if percent < 100 {
                percent += [0, 0, 0, 0, 0, 0, 0, 0, 1].randomElement() ?? 0
              }
            }
          }
          if percent == 100 {
            isTestResult = true
            cancelLoadingTimer()
          }
        }
      }
      .store(in: &cancellables)
  }
  
  func cancelLoadingTimer() {
    for item in cancellables {
      item.cancel()
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
