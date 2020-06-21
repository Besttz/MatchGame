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
        cell.configureCell(cards[indexPath.row])
        
        // RETURN
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the tapped cell
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check if this card if tapped or matched
        if !(cell?.card!.isFlipped)! && !(cell?.card!.isMatched)! {
            
            
            cell?.flipUp()
            
            // Check if there is card being fliped
            if let old = flipingCell {
                
                // Check if this two care match
                if cell?.card?.image == old.card?.image {
                    
                    // Mark them matched and vanish
                    cell?.card?.isMatched = true
                    old.card?.isMatched = true
                    //
                    cell?.remove()
                    old.remove()
                } else {
                    cell?.flipBack()
                    old.flipBack()
                }
                
                //Set current record cell as nil
                flipingCell = nil
            } else {
                flipingCell = cell
            }
        }
    }
}

