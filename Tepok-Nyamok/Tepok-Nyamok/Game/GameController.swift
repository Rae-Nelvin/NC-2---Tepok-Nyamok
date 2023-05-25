//
//  GameController.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import GameKit

class GameController {

    // MARK: UI Components
    var exitButton: UIButton!
    var revealButton: UIButton!
    var cardLabel: UIView!
    var table: UIView!
    var cardsLeftLabel: UILabel!
    var cardsLabel: UILabel!
    var cardImage: UIImageView!
    var doubleTap: UITapGestureRecognizer!
    var player2Rectangle: UIView!
    var player3Rectangle: UIView!
    var player4Rectangle: UIView!
    var player5Rectangle: UIView!

    //MARK: BackEnd Components
    var cards: [Card] = cardLists.lists
    var gameKitManager: GameKitManager!
    var revealedCards: [Card] = []

    init() {
        gameKitManager = GameKitManager.shared
        gameKitManager.delegate = self
    }

    func addRevealedCard(card: Card) {
        revealedCards.append(card)
    }


    func removeCards() {
        if cards.count < 1 {
            cards = cardLists.lists
        } else {
            cards.remove(at: 0)
        }
    }

    func checkWin(player: Player) {

        //        if player.cards.count < 1 {
        //            self.player.isWin = true
        //        }
    }

    func checkCard(card: Card) -> Bool {
        return cards.first!.name == card.name
    }

    @objc func doubleTapTriggered() {
        if self.checkCard(card: (self.gameKitManager.player?.cards.first)!) == true {
            print("Correct")
        } else {
            print("Wrong Tapped")
        }
    }

    private func sendGameDataToPlayers(_ data: Data) {
        self.gameKitManager.sendGameData(data)
    }
    
    private func updateOtherPlayersView(with card: Card) {
        DispatchQueue.main.async {
            // Update the cardImage view with the revealed card's image
            self.cardImage.image = UIImage(named: card.photo)
        }
    }

    private func handleReceivedGameData(_ data: Data, fromPlayer player: GKPlayer) {

    }
}

extension GameController: GameKitManagerDelegate {
    func gameKitManagerDidAuthenticate() {
        // Handle authentication success
    }

    func gameKitManagerDidFailToAuthenticateWithError(_ error: Error) {
        // Handle authentication failure
    }

    func gameKitManagerDidCreateSession() {
        // Handle session creation success
    }

    func gameKitManagerDidFailToCreateSessionWithError(_ error: Error) {
        // Handle session creation failure
    }

    func gameKitManagerDidJoinSession() {
        // Handle session join success
    }

    func gameKitManagerDidFailToJoinSessionWithError(_ error: Error) {
        // Handle session join failure
    }

    func gameKitManagerDidReceiveData(_ data: Data, fromPlayer player: GKPlayer) {
        // Handle received data from other players
    }
}
