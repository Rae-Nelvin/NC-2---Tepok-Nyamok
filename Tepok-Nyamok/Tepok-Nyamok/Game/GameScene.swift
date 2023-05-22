//
//  GameScene.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    
    private var player: Player = Player(name: "Leonardo")
    private var exitButton: UIButton!
    private var revealButton: UIButton!
    private var cardLabel: UIView!
    private var table: UIView!
    private var cardsLeftLabel: UILabel!
    private var cardsLabel: UILabel!
   
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(named: "Cream-Yellow")!
        self.player.assignCards()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        if let view = scene?.view {
            exitButton = UIButton().generateExitButton()
            view.addSubview(exitButton)
            
            cardLabel = generateColumn(string: "5")
            view.addSubview(cardLabel)
            
            table = UIView()
            table.layer.cornerRadius = 10
            table.backgroundColor = .gray
            table.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(table)
            
            cardsLeftLabel = UILabel().generateText(string: "Cards Left :", fontSize: 28, fontWeight: .regular)
            view.addSubview(cardsLeftLabel)

            cardsLabel = UILabel().generateText(string: "\(self.player.cards.count)", fontSize: 28, fontWeight: .regular)
            view.addSubview(cardsLabel)
            
            revealButton = UIButton().generateButton(string: "Reveal", tag: 1)
            revealButton.addTarget(self, action: #selector(revealCard), for: .touchUpInside)
            view.addSubview(revealButton)
        }
    }
    
    private func setupConstraints() {
        if let view = scene?.view {
            NSLayoutConstraint.activate([
                exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
                
                cardLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                cardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                table.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 41),
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
    
    @objc private func revealCard() {
        self.player.revealCard()
    }
}
