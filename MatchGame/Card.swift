//
//  Card.swift
//  MatchGame
//
//  Created by ZhangTommy on 20/6/20.
//  Copyright © 2020 Tommy Zhang. All rights reserved.
//

import Foundation

class Card {
    
    var image = ""
    var isMatched = false
    var isFlipped = false
    
    init(_ name:String) {
        image = name
    }
}
