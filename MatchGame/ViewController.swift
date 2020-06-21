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
    
    var timer:Timer?
    var time = 60*1000
    
    var sound:SoundManager = SoundManager()
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var timeLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cards = model.getCards()
        collection.dataSource = self
        collection.delegate = self
        
        // Initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sound.playSound(.shuffle)
    }
    // MARK: - Timer
    
    @objc func timerFired() {
        
        time -= 1
        let sec:Double = Double(time)/1000.0
        timeLable.text = String(format: "Time: %.2f", sec)
        
        if time == 0 {
            timeLable.textColor = UIColor.red
            timer?.invalidate()
            checkWin()
        }
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
        
        // Check if the timer is  stop
        if time == 0 {
            return
        }
        
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
                    sound.playSound(.match)
                    
                } else {
                    cell?.flipBack()
                    if oldCell.card === old {
                        oldCell.flipBack()
                    } else {
                        old.isFlipped = false
                    }
                    sound.playSound(.wrong)
                }
                
                //Set current record cell as nil
                flipingCard = nil
                flipingCell = nil
            } else {
                sound.playSound(.flip)
                flipingCard = cell?.card
                flipingCell = cell
            }
        }
        checkWin()
    }
    
    func checkWin() {
        
        var win = true
        for card in cards {
            if !card.isMatched {
                win = false
                break
            }
        }
        if win {
            showAlert(title: "Congratulations!", message: "Win!")
            timer?.invalidate()
            sound.playSound(.match)
        } else if time == 0 {
            showAlert(title: "Sorry!", message: "Time is Up!")
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert,animated: true)
    }
}

