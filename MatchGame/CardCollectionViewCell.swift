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
        front.alpha = 1
        back.alpha = 1
        
        // Check if this card is macthed
        if !card.isMatched {
            
            // Check if this card is fliped
            if card.isFlipped {
                UIView.transition(from: back, to: front, duration: 0.0, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
            } else {
                flipBack(0.0)
            }
            
        } else {
            front.alpha = 0
            back.alpha = 0
        }
        
    }
    
    func flipUp(_ duration:TimeInterval = 0.3) {
        
        if  !card!.isMatched && !card!.isFlipped {
            
            // Set card flipped
            card!.isFlipped = true
            
            // Animation 
            UIView.transition(from: back, to: front, duration: duration, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        }
    }
    
    func flipBack(_ duration:TimeInterval = 0.3) {
        
        // Make a delay
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
            // Flipped back animation
            self.card!.isFlipped = false
            UIView.transition(from: self.front, to: self.back, duration: duration, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        })
        
        
    }
    
    func remove()  {
        back.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.front.alpha = 0
        }, completion: nil)
        
    }
}
