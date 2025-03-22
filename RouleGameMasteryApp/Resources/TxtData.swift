//
//  TxtData.swift
//

import Foundation

enum Txt {
  static let welcome = [
    "This is not a gambling game, but a tool to understand the logic of roulette. Learn how bets work, learn the math of the game and test strategies without risk.",
    
    "Analyze, test, find patterns - all for an informed game."
  ]
    
  static let infoTitle = [
    "From Trainee to Casino Executive",
    "AI-Generated Questions",
    "Need Help? Use Hints!",
    "Play, Learn, and Win",
    "Disclaimer"
  ]
  
  static let infoDescr = [
    "Start your journey as a rookie dealer and climb the ranks by proving your knowledge. Each correct answer earns you rewards, while mistakes bring penalties. Can you make it to the top before your luck runs out?",
    "Every quiz is unique! Our AI crafts dynamic questions across casino topics—game rules, strategies, etiquette, and management. The challenge grows with each stage.",
    "Stuck on a question? Use a hint to skip it, but remember—you won’t earn rewards for skipped questions. Choose wisely!",
    "Test your skills, master the casino world, and rise through the ranks. The odds are in your hands!",
    "This game is for educational and entertainment purposes only. It does not promote gambling but offers insight into casino operations in an engaging way. Good luck!"
  ]
  
  static let lectureTitle = [
    "Casino Basics",
    "Casino Dealers",
    "Roulette",
    "Poker",
    "Blackjack",
    "Slot Machines",
    "Probabilities and Strategies",
    "Responsible Gambling",
    "Casino Etiquette"
  ]
  
  static let lectiononeList  = [
    "Gaming Operations – Includes table games (poker, blackjack, roulette) and slot machines, each with specific rules and payout structures.",
    "Dealer and Staff Roles – Dealers handle games, ensuring fairness and enforcing rules, while pit bosses supervise overall operations.",
    "Security and Fair Play – Casinos monitor gameplay to prevent cheating and ensure a safe environment. Surveillance cameras and trained personnel help maintain integrity.",
    "Player Rewards and Comps – Regular players receive bonuses, free plays, or exclusive perks to encourage loyalty.",
    "Responsible Gaming – Casinos promote safe gambling by setting betting limits and offering support for problem gambling."
  ]
  
  static let lectionTwoList = [
    "Straight Up – Betting on a single number.",
    "Split – Betting on two adjacent numbers.",
    "Street – Betting on a row of three numbers.",
    "Red/Black – Betting on the ball landing on a red or black number.",
    "Even/Odd – Betting on an even or odd number.",
    "High/Low – Betting on numbers 1-18 or 19-36."
  ]
  
  static let lectureFourList = [
    "Texas Hold’em – Each player gets two private cards and shares five community cards to form the best hand.",
    "Omaha – Similar to Texas Hold’em, but players receive four private cards and must use exactly two.",
    "Five-Card Draw – Each player gets five private cards and can exchange some to improve their hand."
  ]
  
  static let letureFourSecondList =  [
    "Bluffing – Pretending to have a strong hand to force opponents to fold.",
    "Position Play – Acting later in a round provides more information about opponents’ moves.",
    "Bankroll Management – Controlling bets to stay in the game longer."
  ]
  
  static let lectureFiveList = [
    "Always hit on 11 or lower.",
    "Stand on 17 or higher.",
    "Double down on 10 or 11 if the dealer has a lower total.",
    "Never take insurance, as it benefits the casino."
  ]
  
  static let lectureFiveSeconList = [
    "+1 to low cards (2–6)",
    "0 to neutral cards (7–9)",
    " -1 to high cards (10–Ace)"
  ]
  
  static let lectureSixList = [
    "Classic Slots – Simple 3-reel machines with basic symbols like fruits and bars.",
    "Video Slots – Advanced 5-reel machines with animations, bonus rounds, and special features.",
    "Progressive Jackpots – A portion of each bet contributes to a growing jackpot that can reach millions."
  ]
  
  static let lectureSevenList = [
    "Blackjack Strategy: Using optimal decisions based on probability reduces losses.",
    "Poker Tactics: Skilled players use probability, bluffing, and position to gain an edge.",
    "Bet Sizing: Managing bankroll and avoiding risky bets increases long-term survival."
  ]
  
  static let lectureEightList = [
    "Set a Budget: Decide in advance how much money can be spent without affecting daily life.",
    "Limit Playing Time: Avoid prolonged sessions to prevent chasing losses.",
    "Understand the Odds: Games are designed with a house edge, meaning the casino always has an advantage in the long run.",
    "Avoid Emotional Betting: Playing under stress or frustration leads to poor decision-making."
  ]
  
  static let lectureEightSecondList = [
    "Deposit and Loss Limits: Players can set restrictions on how much they deposit or lose over a set period.",
    "Self-Exclusion Programs: A voluntary option that blocks access to gambling sites or venues for a specific time.",
    "Reality Checks: Notifications reminding players how long they have been gambling.",
    "By following these principles, players can enjoy casino games without financial or emotional harm. Now, let’s test your knowledge in the quiz!"
  ]
  
  static let lectureNineList = [
    "Know the Game Rules: Avoid slowing down the game by asking for explanations.",
    "Respect the Dealer: Dealers are professionals—treat them courteously.",
    "Handle Chips Properly: Place bets neatly and wait for payouts without grabbing chips too early.",
    "No Excessive Celebrations: Winning is exciting, but be mindful of others."
  ]
  
  static let lectureNineSecondList = [
    "No Phones at Tables: Many casinos ban phone use during play to prevent distractions.",
    "Drink Responsibly: Alcohol is available, but excessive drinking can lead to poor decisions.",
    "Tipping: In many countries, it’s customary to tip dealers and waitstaff."
  ]
  
  static let status = [
    "Newbie",
    "Trainee",
    "Dealer",
    "Pit Boss",
    "Manager",
    "Executive"
  ]
  static let quizMenuDesc = [
    "This stage tests your basic knowledge of casino operations, dealer responsibilities, and popular games like roulette, poker, and blackjack. You'll learn about casino etiquette, chip handling, and fundamental rules. Get ready to start your journey!",
    "This stage challenges your understanding of casino mathematics, advanced dealer strategies, and in-depth game rules. You'll explore betting systems, payout calculations, and proper game management techniques. Prepare to refine your skills and elevate your expertise!",
    "This stage delves into the essentials of casino supervision, including player behavior analysis, payout control, and slot machine operations. You'll learn how to handle disputes, ensure game integrity, and manage the casino floor efficiently. Get ready to step up your leadership skills!",
    "This stage focuses on the financial management of a casino, handling high-stakes VIP clients, and ensuring compliance with industry regulations. You'll explore revenue control, risk assessment, and strategic decision-making to keep the casino running smoothly. Prepare to take charge at the highest level!",
    "The ultimate test of your expertise, this stage covers high-level risk management, staff supervision, and overall casino operations. You'll tackle complex decision-making scenarios, regulatory challenges, and strategic planning to ensure the casino’s success. Only the most skilled make it to the top—are you ready?"
  ]
  static let dot = "\u{2022}"
}

let jsonString =
"""
{
    "questions": [
        {
            "text": "What is the primary role of a casino dealer?",
            "answers": ["Shuffle", "Pay winnings", "Run games"],
            "rightAnswer": 3
        },
        {
            "text": "In roulette, what colors are the numbered pockets?",
            "answers": ["Red & Black", "Green & Blue", "Black & White"],
            "rightAnswer": 1
        },
        {
            "text": "Which hand value wins automatically in blackjack?",
            "answers": ["20", "21", "22"],
            "rightAnswer": 2
        },
        {
            "text": "What is the objective in poker?",
            "answers": ["Lose chips", "Bluff", "Have best hand"],
            "rightAnswer": 3
        },
        {
            "text": "What does RTP stand for in slot machines?",
            "answers": ["Return to Play", "Return to Player", "Rate to Profit"],
            "rightAnswer": 2
        },
        {
            "text": "What is the house edge?",
            "answers": ["Player profit", "Casino advantage", "Tie breaker"],
            "rightAnswer": 2
        },
        {
            "text": "What must players do before touching poker chips?",
            "answers": ["Say 'Bet'", "Wait for dealer", "Wash hands"],
            "rightAnswer": 2
        },
        {
            "text": "What is the name of the wheel used in roulette?",
            "answers": ["Spin Wheel", "Fortune Wheel", "Roulette Wheel"],
            "rightAnswer": 3
        },
        {
            "text": "What happens if a player goes over 21 in blackjack?",
            "answers": ["They win", "They bust", "Dealer busts"],
            "rightAnswer": 2
        },
        {
            "text": "What is considered proper casino etiquette?",
            "answers": ["Tip dealer", "Take chips by force", "Change bets mid-round"],
            "rightAnswer": 1
        }
    ]
}
"""
