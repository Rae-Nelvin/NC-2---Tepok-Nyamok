//
//  GameRulesScreen.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import SpriteKit

class GameRulesScreen: UIViewController {
    
    private var titleLabel = UILabel()
    private var rules1: UILabel!
    private var rules1_1: UILabel!
    private var rules2: UILabel!
    private var rules2_1: UILabel!
    private var rules3: UILabel!
    private var rules3_1: UILabel!
    private var rules3_2: UILabel!
    private var rules4: UILabel!
    private var rules4_1: UILabel!
    private var rules5: UILabel!
    private var rules5_1: UILabel!
    private var continueButton = UIButton(type: .system)
    private var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel = UILabel().generateText(string: "Game's Rules", fontSize: 28, fontWeight: .bold)
        view.addSubview(titleLabel)
        
        rules1 = UILabel().generateText(string: "1. Each player will have 20", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules1)
        rules1_1 = UILabel().generateText(string: "shuffled cards", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules1_1)
        
        rules2 = UILabel().generateText(string: "2. Each player will reveal their cards ", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules2)
        rules2_1 = UILabel().generateText(string: "one by one", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules2_1)
        
        rules3 = UILabel().generateText(string: "3. If the revealed card matched with", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules3)
        rules3_1 = UILabel().generateText(string: "the top indicator, each player have", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules3_1)
        rules3_2 = UILabel().generateText(string: "to triple tap the card fast enough.", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules3_2)
        
        rules4 = UILabel().generateText(string: "4. The top hand, will get the", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules4)
        rules4_1 = UILabel().generateText(string: "deck's card.", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules4_1)
        
        rules5 = UILabel().generateText(string: "5. If you've empty your cards", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules5)
        rules5_1 = UILabel().generateText(string: "you won the game", fontSize: 20, fontWeight: .regular)
        view.addSubview(rules5_1)
        
        continueButton = UIButton().generateButton(string: "Continue", tag: 1)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            
            rules1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            rules1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rules1_1.topAnchor.constraint(equalTo: rules1.bottomAnchor, constant: 10),
            rules1_1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            rules2.topAnchor.constraint(equalTo: rules1_1.bottomAnchor, constant: 40),
            rules2.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rules2_1.topAnchor.constraint(equalTo: rules2.bottomAnchor, constant: 10),
            rules2_1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            rules3.topAnchor.constraint(equalTo: rules2_1.bottomAnchor, constant: 40),
            rules3.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rules3_1.topAnchor.constraint(equalTo: rules3.bottomAnchor, constant: 10),
            rules3_1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rules3_2.topAnchor.constraint(equalTo: rules3_1.bottomAnchor, constant: 10),
            rules3_2.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            rules4.topAnchor.constraint(equalTo: rules3_2.bottomAnchor, constant: 40),
            rules4.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rules4_1.topAnchor.constraint(equalTo: rules4.bottomAnchor, constant: 10),
            rules4_1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            rules5.topAnchor.constraint(equalTo: rules4_1.bottomAnchor, constant: 40),
            rules5.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rules5_1.topAnchor.constraint(equalTo: rules5.bottomAnchor, constant: 10),
            rules5_1.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            continueButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -92),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func continueButtonTapped() {
        print("Continue Button Tapped")
        let gameScreen = GameScreen()
        gameScreen.modalPresentationStyle = .fullScreen
        self.present(gameScreen, animated: true)
    }
    
}
