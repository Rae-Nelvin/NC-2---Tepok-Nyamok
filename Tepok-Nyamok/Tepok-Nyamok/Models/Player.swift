//
//  Player.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import Foundation

class Player: Identifiable {
    var id = UUID()
    let name: String
    var cards: [Card]
    var isWin: Bool
    var isTurn: Bool
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.cards = []
        self.isWin = false
        self.isTurn = false
        assignCards()
    }
    
    func assignCards() {
        cards = cardLists.lists.shuffled()
        self.cards = Array(cards.prefix(upTo: 20))
    }
    
    func revealCard() -> Card? {
        guard !cards.isEmpty else { return nil }
        return cards.removeFirst()
    }
}
