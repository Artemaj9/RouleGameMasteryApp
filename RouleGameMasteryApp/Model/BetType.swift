//
//  BetType.swift
//

import Foundation

enum BetType {
    case red, black
    case odd, even
    case low(ClosedRange<Int>) // 1-12, 13-24, 25-36
    case straight(Int) // Single number
    case split(Int, Int) // Two adjacent numbers
    case street([Int]) // Row of 3
    case square([Int]) // Block of 4
    case sixLine([Int]) // Two rows of 3
}
