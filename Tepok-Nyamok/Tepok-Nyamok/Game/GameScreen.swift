//
//  GameScreen.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit

class GameScreen: UIViewController {
    
    private var gc: GameController = GameController()
    private var exitButton: UIButton!
    private var revealButton: UIButton!
    private var cardLabel: UIView!
    private var table: UIView!
    private var cardsLeftLabel: UILabel!
    private var cardsLabel: UILabel!
    private var cardImage: UIImageView!
    private var doubleTap: UITapGestureRecognizer!
    private var player2Rectangle: UIView!
    private var player3Rectangle: UIView!
    private var player4Rectangle: UIView!
    private var player5Rectangle: UIView!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if gc.isRun == false {
            showWinScreen()
        }
    }
    
    private func setupViews() {
        exitButton = UIButton().generateExitButton()
        view.addSubview(exitButton)
        
        cardLabel = generateColumn(string: gc.cards.first?.name ?? "")
        view.addSubview(cardLabel)
        
        table = UIView()
        table.layer.cornerRadius = 10
        table.backgroundColor = .gray
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        cardsLeftLabel = UILabel().generateText(string: "Cards Left :", fontSize: 28, fontWeight: .regular)
        view.addSubview(cardsLeftLabel)
        
        cardsLabel = UILabel().generateText(string: "\(self.gc.player.cards.count)", fontSize: 28, fontWeight: .regular)
        view.addSubview(cardsLabel)
        
        revealButton = UIButton().generateButton(string: "Reveal", tag: 1)
        revealButton.addTarget(self, action: #selector(revealCard), for: .touchUpInside)
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
        if !gc.isRun {
            gc.removeCards()
            cardLabel.removeFromSuperview()
            cardLabel = generateColumn(string: self.gc.cards.first?.name ?? "")
            view.addSubview(cardLabel)
            cardLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            cardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            let card = self.gc.player.revealCard()
            cardsLabel.text = "\(self.gc.player.cards.count)"
            cardImage = UIImageView(image: UIImage(named: card?.photo ?? ""))
            view.addSubview(cardImage)
            cardImage.frame = CGRect(x: 0, y: view.bounds.height, width: 131, height: 174)
            
            UIView.animate(withDuration: 0.5) {
                self.cardImage.frame = CGRect(x: 130, y: 286, width: 131, height: 174)
            }
            gc.checkWin(player: gc.player)
        } else {
            showWinScreen()
        }
        
    }
    
    @objc private func doubleTapTriggered() {
        if gc.checkCard(card: gc.player.cards.first!) == true {
            print("Correct")
        } else {
            print("Wrong Tapped")
        }
        
    }
}
