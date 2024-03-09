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
    var table: UIImageView!
    var cardsLeftLabel: UILabel!
    var cardsLabel: UILabel!
    var cardImage: UIImageView!
    var doubleTap: UITapGestureRecognizer!
    var player1Hand: UIImageView!
    var player2Hand: UIImageView!
    var player3Hand: UIImageView!
    
    //MARK: BackEnd Components
    var cards: [Card] = cardLists.lists
    var gameKitManager: GameKitManager!
    var revealedCards: [Card] = []
    var isMatch: Bool = false
    var hands: [Player] = []

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
        exitButton.addTarget(self, action: #selector(exitGame), for: .touchUpInside)
        view.addSubview(exitButton)

        cardLabel = generateColumn(string: cards.first?.name ?? "")
        view.addSubview(cardLabel)

        table = UIImageView(image: UIImage(named: "Poker Table"))
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

        doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapTriggered))
        doubleTap.numberOfTapsRequired = 3
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
        ])
    }

    private func generateColumn(string: String) -> UIView {
        let column = UIView()
        column.backgroundColor = UIColor(named: "Orange")
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
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        blackView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: blackView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: blackView.centerYAnchor).isActive = true

        UIView.animate(withDuration: 0.5) {
            blackView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            UIView.animate(withDuration: 0.5) {
                blackView.alpha = 0
            } completion: { _ in
                blackView.removeFromSuperview()
            }
        }
    }
    
    private func showDrawScreen() {
        let blackView = UIView()
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackView)
        blackView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        blackView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        blackView.center = view.center

        let label = UILabel()
        label.text = "You Have to Draw \(self.revealedCards.count) Cards"
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        blackView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: blackView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: blackView.centerYAnchor).isActive = true

        UIView.animate(withDuration: 0.5) {
            blackView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            UIView.animate(withDuration: 0.5) {
                blackView.alpha = 0
            } completion: { _ in
                blackView.removeFromSuperview()
            }
        }
    }
    
    private func player1HandReveal() {
        player1Hand = UIImageView(image: UIImage(named: "Spongebob"))
        view.addSubview(player1Hand)
        
        player1Hand.frame = CGRect(x: view.center.x, y: view.frame.maxY + 500, width: 364, height: 500)
        
        UIView.animate(withDuration: 1) { [self] in
            player1Hand.frame = CGRect(x: 0, y: 406, width: 364, height: 500)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            UIView.animate(withDuration: 1) { [self] in
                player1Hand.frame = CGRect(x: view.center.x, y: view.frame.maxY + 500, width: 364, height: 600)
            }
            DispatchQueue.main.async {
                self.player1Hand.removeFromSuperview()
            }
        }
        self.checkLastHand()
    }
    
    private func player2HandReveal() {
        player2Hand = UIImageView(image: UIImage(named: "Patrick"))
        view.addSubview(player2Hand)
        player2Hand.frame = CGRect(x: view.frame.maxX, y: view.frame.maxY + 364, width: 364, height: 500)
        
        UIView.animate(withDuration: 1) { [self] in
            player2Hand.frame = CGRect(x: 150, y: 376, width: 364, height: 500)
            player2Hand.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIView.animate(withDuration: 1) { [self] in
                player2Hand.frame = CGRect(x: view.frame.maxX, y: view.frame.maxY + 364, width: 364, height: 500)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                self.player2Hand.removeFromSuperview()
            }
        }
        self.checkLastHand()
    }
    
    private func player3HandReveal() {
        player3Hand = UIImageView(image: UIImage(named: "Behemoth"))
        view.addSubview(player3Hand)
        player3Hand.frame = CGRect(x: view.frame.minX, y: view.frame.maxY + 500, width: 264, height: 700)
        
        UIView.animate(withDuration: 1) { [self] in
            player3Hand.frame = CGRect(x: -50, y: 206, width: 264, height: 700)
            player3Hand.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIView.animate(withDuration: 1) { [self] in
                player3Hand.frame = CGRect(x: view.frame.minX, y: view.frame.maxY + 264, width: 364, height: 500)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                self.player3Hand.removeFromSuperview()
            }
        }
        self.checkLastHand()
    }

    @objc private func revealCard() {
        if gameKitManager.playingGame && !isMatch {
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
            checkDeckCard()
            if !isMatch {
                checkWin()
            }
        } else if !gameKitManager.playingGame {
            showWinScreen()
        }
    }
    
    func checkCard(card: Card) -> Bool {
        return cards.last!.name == card.name
    }
    
    @objc func doubleTapTriggered() {
        print(isMatch)
        if !hands.contains(gameKitManager.player!) && isMatch {
            hands.append(gameKitManager.player!)
            revealPlayerHands(receivedHand: gameKitManager.player!)
            sendPlayerHandsData(gameKitManager.player!)
        }
    }
    
    private func revealPlayerHands(receivedHand: Player) {
        var count = 1
        for hand in hands {
            if receivedHand == hand {
                break
            }
            count += 1
        }
        revealHand(player: count)
    }
    
    private func revealHand(player: Int) -> Void {
        switch player {
        case 1: return self.player1HandReveal()
        case 2: return self.player2HandReveal()
        case 3: return self.player3HandReveal()
        default: return self.player1HandReveal()
        }
    }
    
    @objc private func exitGame() {
        let loadingScreen = LoadingScreen()
        loadingScreen.modalPresentationStyle = .fullScreen
        self.present(loadingScreen, animated: true, completion: nil)
    }
    
    // MARK: BackEnd Logics
    private func addRevealedCard(card: Card) {
        revealedCards.append(card)
        self.hands = []
    }
    
    private func checkDeckCard() {
        if revealedCards.last?.name == cards.first?.name {
            isMatch = true
        } else {
            isMatch = false
        }
    }
    
    private func removeCards() {
        if cards.count < 1 {
            cards = cardLists.lists
        } else {
            cards.remove(at: 0)
        }
    }
    
    private func checkWin() {
        if gameKitManager.player?.cards.count == 0 {
            gameKitManager.youWon = true
            showWinScreen()
        }
    }
    
    private func checkLastHand() {
        if gameKitManager.players!.count + 1 == 2 && hands.count == 2 {
            if gameKitManager.player == hands.last {
                self.showDrawScreen()
                for card in revealedCards {
                    gameKitManager.player?.cards.append(card)
                    revealedCards.remove(at: 0)
                }
                self.hands = []
                isMatch.toggle()
                sendIsMatchFalse(isMatch)
                cardsLabel.text = "\((self.gameKitManager.player?.cards.count)!)"
            }
        } else if gameKitManager.players!.count + 1 == 3 {
            if gameKitManager.player == hands.last && hands.count == 3 {
                self.showDrawScreen()
                for card in revealedCards {
                    gameKitManager.player?.cards.append(card)
                    revealedCards.remove(at: 0)
                }
                cardsLabel.text = "\((self.gameKitManager.player?.cards.count)!)"
                self.hands = []
                isMatch.toggle()
                sendIsMatchFalse(isMatch)
            }
        }
        checkWin()
    }
    
    private func updateOtherPlayersView(with card: Card) {
        DispatchQueue.main.async { [self] in
            // Update the cardImage view with the revealed card's image
            removeCards()
            addRevealedCard(card: card)
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
            checkDeckCard()
        }
    }
    
    private func sendRevealedCardData(_ card: Card) {
        let cardData = encodeData(card)
        if let cardData = cardData {
            gameKitManager.sendGameData(cardData)
        }
    }
    
    private func sendPlayerHandsData(_ hand: Player) {
        let handData = encodeData(hand)
        if let handData = handData {
            gameKitManager.sendGameData(handData)
        }
    }
    
    private func sendIsMatchFalse(_ match: Bool) {
        let matchFalse = encodeData(match)
        if let matchData = matchFalse {
            gameKitManager.sendGameData(matchData)
        }
    }

    private func handleReceivedGameData(_ data: Data, fromPlayer player: GKPlayer) {
        if let card: Card = decodeData(data) {
            updateOtherPlayersView(with: card)
            print(hands)
        } else if let hand: Player = decodeData(data) {
            if !self.hands.contains(hand) {
                self.hands.append(hand)
                self.revealPlayerHands(receivedHand: hand)
            }
        } else if let match: Bool = decodeData(data) {
            self.isMatch = match
        }
    }
    
    // MARK: Encode and Decode
    private func encodeData<T: Codable>(_ object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(object)
        } catch {
            print("Error encoding data: \(error)")
            return nil
        }
    }

    private func decodeData<T: Codable>(_ data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding data: \(error)")
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
