//
//  Card.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import Foundation

class Card: Identifiable, Hashable, Codable {
    
    var id = UUID()
    let name: String
    let photo: String
    
    init(name: String, photo: String) {
        self.id = UUID()
        self.name = name
        self.photo = photo
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct cardLists {
    static let lists: [Card] = [
        Card(name: "ACE", photo: "AceSpades"),
        Card(name: "2", photo: "2Clubs"),
        Card(name: "3", photo: "3Clubs"),
        Card(name: "4", photo: "4Clubs"),
        Card(name: "5", photo: "5Clubs"),
        Card(name: "6", photo: "6Clubs"),
        Card(name: "7", photo: "7Clubs"),
        Card(name: "8", photo: "8Clubs"),
        Card(name: "9", photo: "9Clubs"),
        Card(name: "10", photo: "10Clubs"),
        Card(name: "JACK", photo: "JackClubs"),
        Card(name: "QUEEN", photo: "QueenClubs"),
        Card(name: "KING", photo: "KingClubs"),
        Card(name: "ACE", photo: "AceClubs"),
        Card(name: "2", photo: "2Diamonds"),
        Card(name: "3", photo: "3Diamonds"),
        Card(name: "4", photo: "4Diamonds"),
        Card(name: "5", photo: "5Diamonds"),
        Card(name: "6", photo: "6Diamonds"),
        Card(name: "7", photo: "7Diamonds"),
        Card(name: "8", photo: "8Diamonds"),
        Card(name: "9", photo: "9Diamonds"),
        Card(name: "10", photo: "10Diamonds"),
        Card(name: "JACK", photo: "JackDiamonds"),
        Card(name: "QUEEN", photo: "QueenDiamonds"),
        Card(name: "KING", photo: "KingDiamonds"),
        Card(name: "ACE", photo: "AceDiamonds"),
        Card(name: "2", photo: "2Hearts"),
        Card(name: "3", photo: "3Hearts"),
        Card(name: "4", photo: "4Hearts"),
        Card(name: "5", photo: "5Hearts"),
        Card(name: "6", photo: "6Hearts"),
        Card(name: "7", photo: "7Hearts"),
        Card(name: "8", photo: "8Hearts"),
        Card(name: "9", photo: "9Hearts"),
        Card(name: "10", photo: "10Hearts"),
        Card(name: "JACK", photo: "JackHearts"),
        Card(name: "QUEEN", photo: "QueenHearts"),
        Card(name: "KING", photo: "KingHearts"),
        Card(name: "ACE", photo: "AceHearts"),
        Card(name: "2", photo: "2Spades"),
        Card(name: "3", photo: "3Spades"),
        Card(name: "4", photo: "4Spades"),
        Card(name: "5", photo: "5Spades"),
        Card(name: "6", photo: "6Spades"),
        Card(name: "7", photo: "7Spades"),
        Card(name: "8", photo: "8Spades"),
        Card(name: "9", photo: "9Spades"),
        Card(name: "10", photo: "10Spades"),
        Card(name: "JACK", photo: "JackSpades"),
        Card(name: "QUEEN", photo: "QueenSpades"),
        Card(name: "KING", photo: "KingSpades"),
    ]
}
