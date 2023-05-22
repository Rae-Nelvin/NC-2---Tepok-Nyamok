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
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.cards = []
    }
    
    func assignCards() {
        var cards: [Card] = []
        var assignedSet = Set<Card>()
        
        while cards.count < 20 {
            let shuffledCards = cardLists.lists.shuffled()
            let data = shuffledCards.prefix(1)[0]
            
            if !assignedSet.contains(data) {
                cards.append(data)
                assignedSet.insert(data)
            }
        }
        self.cards = cards
    }
    
    func revealCard() -> Card? {
        guard !cards.isEmpty else { return nil }
        return cards.removeFirst()
    }
}
