//
//  GameController.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import GameKit

class GameController {
    
    var isRun: Bool = true
    var cards: [Card] = cardLists.lists
    var player: Player = Player(name: "Leonardo")
    
    init() {
        
    }
    
    func removeCards() {
        if cards.count < 1 {
            cards = cardLists.lists
        } else {
            cards.remove(at: 0)
        }
    }
    
    func checkWin(player: Player) {
        
        if player.cards.count < 1 {
            self.player.isWin = true
        }
    }
    
    func checkCard(card: Card) -> Bool {
        return cards.first!.name == card.name
    }
    
}
