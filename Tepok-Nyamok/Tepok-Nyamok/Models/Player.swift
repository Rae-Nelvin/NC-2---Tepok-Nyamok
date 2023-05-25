//
//  Player.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import Foundation

class Player: Identifiable, Equatable,  Codable {
    var id = UUID()
    let name: String
    var cards: [Card]
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.cards = []
        assignCards()
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
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
