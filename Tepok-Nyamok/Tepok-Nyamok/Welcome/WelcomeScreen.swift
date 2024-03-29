//
//  ViewController.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 21/05/23.
//

import UIKit
import GameKit

class WelcomeScreen: UIViewController, UINavigationControllerDelegate {
    
    private var gameKitManager: GameKitManager!
    private var titleLabel = UILabel()
    private var startButton = UIButton(type: .system)
    private var nameField: UIView!
    private var appIcon: UIImageView!
    private var playerName: String?
    private var sessionCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        gameKitManager = GameKitManager.shared
        gameKitManager.delegate = self
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        titleLabel = UILabel().generateText(string: "Tepok Nyamok", fontSize: 48, fontWeight: .black)
        view.addSubview(titleLabel)
        
        appIcon = UIImageView(image: UIImage(named: "AppIcon"))
        appIcon.layer.cornerRadius = 10
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appIcon)
        
        nameField = UIView().generateNameLabel(string: gameKitManager.player?.name ?? "", fontSize: 30, fontWeight: .bold)
        view.addSubview(nameField)
        
        startButton = UIButton().generateButton(string: "Start", tag: 1)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.isEnabled = true
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            appIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37),
            appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIcon.widthAnchor.constraint(equalToConstant: 368),
            appIcon.heightAnchor.constraint(equalToConstant: 368),
            
            nameField.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 38),
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 32),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func startButtonTapped() {
        gameKitManager.createSession()
    }
}

extension WelcomeScreen: GameKitManagerDelegate {
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
        let gameRulesScreen = GameRulesScreen()
        gameRulesScreen.modalPresentationStyle = .fullScreen
        self.present(gameRulesScreen, animated: true, completion: nil)
    }
    
    func gameKitManagerDidFailToJoinSessionWithError(_ error: Error) {
        // Handle session join failure
    }
    
    func gameKitManagerDidReceiveData(_ data: Data, fromPlayer player: GKPlayer) {
        // Handle received data from other players
    }
}
