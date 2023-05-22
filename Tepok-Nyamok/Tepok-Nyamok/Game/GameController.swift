//
//  GameController.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import SpriteKit
import GameKit

class GameController {
    
    var isRun: Bool = true
    var cards: [Card] = cardLists.lists
    var player: Player = Player(name: "Leonardo")
    
    init() {
        self.player.assignCards()
    }
    
}
