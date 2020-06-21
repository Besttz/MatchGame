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
        cell?.flipUp()
    }
}

