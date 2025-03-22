//
//  GameViewModel.swift
//

import SwiftUI
import Combine
import CoreImage
import CoreImage.CIFilterBuiltins

final class GameViewModel: ObservableObject {
  @Published var size: CGSize = CGSize(width: 393, height: 851)
  @Published var isSplash = true
  @Published var isTestResult = false
  @AppStorage("isWelcome") var isWelcome = true
  
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
    records = UserDefaultService.shared.getStructs(forKey: UDKeys.records.rawValue) ?? Array(repeating: 0, count: 5)
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
