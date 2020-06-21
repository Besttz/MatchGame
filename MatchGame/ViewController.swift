//
//  ViewController.swift
//  MatchGame
//
//  Created by ZhangTommy on 20/6/20.
//  Copyright © 2020 Tommy Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    
    let model = CardModel()
    var cards = [Card]()
    var flipingCell:CardCollectionViewCell?
    var flipingCard:Card?
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cards = model.getCards()
        collection.dataSource = self
        collection.delegate = self
    }
    
    // MARK: - View Collection Controls
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //  GET
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardView", for: indexPath) as! CardCollectionViewCell
        
        // CONFIGURE
        //        cell.configureCell(cards[indexPath.row])
        
        // RETURN
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let thisCell = cell as? CardCollectionViewCell
        // CONFIGURE as the state of this card
        thisCell?.configureCell(cards[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the tapped cell
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check if this card if tapped or matched
        if !(cell?.card!.isFlipped)! && !(cell?.card!.isMatched)! {
            
            
            cell?.flipUp()
            
            // Check if there is card being fliped
            if let old = flipingCard, let oldCell = flipingCell {
                
                // Check if this two care match
                if cell?.card?.image == old.image {
                    
                    // Mark them matched and vanish
                    cell?.card?.isMatched = true
                    old.isMatched = true
                    //
                    cell?.remove()
                    
                    // Check if the card is still in view
                    if oldCell.card === old {
                        oldCell.remove()
                    }
                    
                } else {
                    cell?.flipBack()
                    if oldCell.card === old {
                        oldCell.flipBack()
                    } else {
                        old.isFlipped = false
                    }
                }
                
                //Set current record cell as nil
                flipingCard = nil
                flipingCell = nil
            } else {
                flipingCard = cell?.card
                flipingCell = cell
            }
        }
    }
}

