//
//  GameScreen.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import GameKit

class GameScreen: UIViewController {
    
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

    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        gameKitManager = GameKitManager.shared
        gameKitManager.delegate = self
        setupViews()
        setupConstraints()
    }
    
    // MARK: UI Logics

    private func setupViews() {
        exitButton = UIButton().generateExitButton()
        view.addSubview(exitButton)

        cardLabel = generateColumn(string: cards.first?.name ?? "")
        view.addSubview(cardLabel)

        table = UIView()
        table.layer.cornerRadius = 10
        table.backgroundColor = .gray
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)

        cardsLeftLabel = UILabel().generateText(string: "Cards Left :", fontSize: 28, fontWeight: .regular)
        view.addSubview(cardsLeftLabel)

        cardsLabel = UILabel().generateText(string: "\(self.gameKitManager.player?.cards.count)", fontSize: 28, fontWeight: .regular)
        view.addSubview(cardsLabel)

        revealButton = UIButton().generateButton(string: "Reveal", tag: 1)
        revealButton.addTarget(self, action: #selector(revealCard), for: .touchUpInside)
        revealButton.isEnabled = true
        view.addSubview(revealButton)

        player2Rectangle = UIView()
        player2Rectangle.layer.cornerRadius = 10
        player2Rectangle.backgroundColor = .white
        player2Rectangle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(player2Rectangle)

        doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapTriggered))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),

            cardLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            table.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 41),
            table.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            table.widthAnchor.constraint(equalToConstant: 368),
            table.heightAnchor.constraint(equalToConstant: 440),

            cardsLeftLabel.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 21),
            cardsLeftLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            cardsLabel.topAnchor.constraint(equalTo: cardsLeftLabel.bottomAnchor, constant: 3),
            cardsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            revealButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            revealButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            player2Rectangle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 4),
            player2Rectangle.topAnchor.constraint(equalTo: cardsLeftLabel.topAnchor, constant: -104),
            player2Rectangle.widthAnchor.constraint(equalToConstant: 64),
            player2Rectangle.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func generateColumn(string: String) -> UIView {
        let column = UIView()
        column.backgroundColor = .gray
        column.layer.cornerRadius = 10
        column.translatesAutoresizingMaskIntoConstraints = false
        column.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 255)
        column.layer.borderWidth = 1
        view?.addSubview(column)

        let label = UILabel()
        label.text = string
        label.font = .systemFont(ofSize: 36)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        column.addSubview(label)

        NSLayoutConstraint.activate([
            column.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 32),
            column.heightAnchor.constraint(equalTo: label.heightAnchor),

            label.centerYAnchor.constraint(equalTo: column.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: column.leadingAnchor, constant: 16)
        ])

        return column
    }

    private func showWinScreen() {
        let blackView = UIView()
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackView)
        blackView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        blackView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        blackView.center = view.center

        let label = UILabel()
        label.text = "You Win"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        blackView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: blackView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: blackView.centerYAnchor).isActive = true

        UIView.animate(withDuration: 0.5) {
            blackView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5) {
                blackView.alpha = 0
            } completion: { _ in
                blackView.removeFromSuperview()
            }
        }
    }

    @objc private func revealCard() {
        if gameKitManager.playingGame {
            removeCards()
            cardLabel.removeFromSuperview()
            cardLabel = generateColumn(string: self.cards.first?.name ?? "")
            view.addSubview(cardLabel)
            cardLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            cardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            let card = self.gameKitManager.player?.revealCard()
            addRevealedCard(card: card!)
            cardsLabel.text = "\((self.gameKitManager.player?.cards.count)!)"
            cardImage = UIImageView(image: UIImage(named: card?.photo ?? ""))
            view.addSubview(cardImage)
            cardImage.frame = CGRect(x: 0, y: 0, width: view.bounds.maxX, height: view.bounds.maxY)

            UIView.animate(withDuration: 0.5) {
                self.cardImage.frame = CGRect(x: 130, y: 286, width: 131, height: 174)
            }
            sendRevealedCardData(card!)
//            checkWin(player: self.gameKitManager.player!)
        } else {
            showWinScreen()
        }
    }
    
    func checkCard(card: Card) -> Bool {
        return cards.last!.name == card.name
    }
    
    @objc func doubleTapTriggered() {
        if self.checkCard(card: (self.gameKitManager.player?.cards.first)!) == true {
            print("Correct")
        } else {
            print("Wrong Tapped")
        }
    }
    
    // MARK: BackEnd Logics
    private func addRevealedCard(card: Card) {
        revealedCards.append(card)
    }
    
    private func removeCards() {
        if cards.count < 1 {
            cards = cardLists.lists
        } else {
            cards.remove(at: 0)
        }
    }
    
    private func sendRevealedCardData(_ card: Card) {
        let cardData = encodeCardData(card)
        if let cardData = cardData {
            gameKitManager.sendGameData(cardData)
        }
    }
    
    private func updateOtherPlayersView(with card: Card) {
        DispatchQueue.main.async { [self] in
            // Update the cardImage view with the revealed card's image
            removeCards()
            cardLabel.removeFromSuperview()
            cardLabel = generateColumn(string: cards.first?.name ?? "")
            view.addSubview(cardLabel)
            cardLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            cardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            cardImage = UIImageView(image: UIImage(named: card.photo))
            view.addSubview(cardImage)
            cardImage.frame = CGRect(x: 0, y: 0, width: view.bounds.maxX, height: view.bounds.maxY)

            UIView.animate(withDuration: 0.5) {
                self.cardImage.frame = CGRect(x: 130, y: 286, width: 131, height: 174)
            }
        }
    }

    private func handleReceivedGameData(_ data: Data, fromPlayer player: GKPlayer) {
        if let card = decodeCardData(data) {
            updateOtherPlayersView(with: card)
        }
    }
    
    // MARK: Encode and Decode
    private func encodeCardData(_ card: Card) -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(card)
        } catch {
            print("Failed to encode card data:", error)
            return nil
        }
    }
    
    private func decodeCardData(_ data: Data) -> Card? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Card.self, from: data)
        } catch {
            print("Failed to decode card data:", error)
            return nil
        }
    }
}

extension GameScreen: GameKitManagerDelegate {
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
        handleReceivedGameData(data, fromPlayer: player)
    }
}
