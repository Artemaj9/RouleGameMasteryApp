//
//  NavigationStateManager.swift
//

import Foundation

enum SelectionState: Hashable, Codable {
  case info
  case lectures
  case game
  case lecture(Int)
}

class NavigationStateManager: ObservableObject {
  @Published var path = [SelectionState]()
}
