//
//  CardCollectionViewCell.swift
//  MatchGame
//
//  Created by ZhangTommy on 20/6/20.
//  Copyright © 2020 Tommy Zhang. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var front: UIImageView!
    
    @IBOutlet weak var back: UIImageView!
    
    var card:Card?
    
    func configureCell(_ card:Card)  {
        
        // Asign the card to this cell varibale
        self.card = card
        
        // Set the cell images
        front.image = UIImage(named: card.image)
        back.image = UIImage(named:"back")
        
        // Check if this card is fliped
        if card.isFlipped {
            UIView.transition(from: back, to: front, duration: 0.0, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        } else {
            flipBack(0.0)
        }
        
    }
    
    func flipUp(_ duration:Double = 0.3) {
        
        if  !card!.isMatched && !card!.isFlipped {
            
            // Set card flipped
            card!.isFlipped = true
            
            // Animation
            UIView.transition(from: back, to: front, duration: duration, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        }
    }
    
    func flipBack(_ duration:Double = 0.3) {
        UIView.transition(from: front, to: back, duration: duration, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
    }
}
