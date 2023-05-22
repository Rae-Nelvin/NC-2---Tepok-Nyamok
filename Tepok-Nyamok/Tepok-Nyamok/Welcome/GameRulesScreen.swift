//
//  GameRulesScreen.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import SpriteKit

class GamesRulesScreen: UIViewController {
    
    private var titleLabel = UILabel()
    private var rectangle = UIView()
    private var continueButton = UIButton(type: .system)
    private var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel = UILabel().generateText(string: "Game's Rules", fontSize: 28, fontWeight: .regular)
        view.addSubview(titleLabel)
        
        rectangle.backgroundColor = .gray
        rectangle.layer.cornerRadius = 10
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle)
        
        continueButton = UIButton().generateButton(string: "Continue", tag: 1)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            
            rectangle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 34),
            rectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangle.widthAnchor.constraint(equalToConstant: 368),
            rectangle.heightAnchor.constraint(equalToConstant: 535),
            
            continueButton.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 32),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func continueButtonTapped() {
        print("Continue Button Tapped")
        let gameViewController = GameViewController()
        let navigationController = UINavigationController(rootViewController: gameViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
}
