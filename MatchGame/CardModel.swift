//
//  CardModel.swift
//  MatchGame
//
//  Created by ZhangTommy on 20/6/20.
//  Copyright © 2020 Tommy Zhang. All rights reserved.
//

import Foundation

class CardModel {
    
    
    func getCards() -> [Card]{
        
        // Declare a new int array
        var cardNum = [Int]()
        var cards = [Card]()
        
        // Generate 8 random numbers for card pair
        while cards.count < 16 {
            
            //Generate a number
            let num = Int.random(in: 1...13)
            
            // Check if it's repeated
            if cardNum.contains(num) {
                continue
            }
            //Add this card
            cardNum.append(num)
            cards.append(Card("card\(num)"))
            cards.append(Card("card\(num)"))
        }
        
        // Randomlize the cards inside the array
        cards.shuffle()
        
        // Return this array
        
        return cards
    }
}
