//
//  TxtData.swift
//

import Foundation

enum Txt {
  static let welcome = [
    "This is not a gambling game, but a tool to understand the logic of roulette. Learn how bets work, learn the math of the game and test strategies without risk.",
    
    "Analyze, test, find patterns - all for an informed game."
  ]
    
  static let infoDescr = "Our app is an analytical tool for learning roulette. It helps you understand the probabilities of different bets, analyze game strategies and test them in practice in the simulator. There are no real money bets here, only mathematical calculations and simulations."
  static let infoList1 = ["Calculate the odds of winning for different types of bets",
                          "Determine Expected Returns",
                         "Test strategies in practice",
                          "Compare theoretical and actual winning probabilities"]

  
  static let infoListNum = [
    "Bet amount - is indicated without currency",
    "Bet type - you can select one or more options",
    "Simple odds: Red/Black, Even/Odd",
    "Dozens: 1-12, 13-24, 25-36",
    "Domestic rates:"
  ]
  
  static let infoList2 = [
    "Straight Up - Bet on a single number",
    "Split - bet on two numbers",
    "Street - a bet on three numbers",
    "Corner - a bet on four numbers",
    "Six Line - bet on six numbers"
  ]
 
  static let dot = "\u{2022}"
}
