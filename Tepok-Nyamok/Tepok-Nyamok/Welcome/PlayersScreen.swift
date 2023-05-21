//
//  PlayersScene.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 21/05/23.
//

import UIKit

class PlayersScreen: UIViewController {
    
    private var titleLabel = UILabel()
    private var players: Int = 1
    private var roomCode: String = "ABC23"
    private var roomCodeTitleLabel = UILabel()
    private var roomCodeLabel = UILabel()
    private var playerColumn = UILabel()
    private var startButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel = generateText(string: "Players 1/5", fontSize: 28, fontWeight: .regular)
        view.addSubview(titleLabel)
        
        roomCodeTitleLabel = generateText(string: "Room Code :", fontSize: 20, fontWeight: .regular)
        view.addSubview(roomCodeTitleLabel)
        
        roomCodeLabel = generateText(string: roomCode, fontSize: 22, fontWeight: .bold)
        view.addSubview(roomCodeLabel)
        
        playerColumn = generateColumn(string: "Player 1")
        view.addSubview(playerColumn)
        
        startButton = generateButton(string: "Start", tag: 1)
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            
            roomCodeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
            roomCodeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            roomCodeLabel.topAnchor.constraint(equalTo: roomCodeTitleLabel.bottomAnchor, constant: 3),
            roomCodeLabel.trailingAnchor.constraint(equalTo: roomCodeTitleLabel.trailingAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func generateText(string: String, fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
        let text = UILabel()
        text.text = string
        text.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }
    
    private func generateButton(string: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(string, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 368).isActive = true
        button.heightAnchor.constraint(equalToConstant: 74).isActive = true
        button.tag = tag
        
        return button
    }
    
    private func generateColumn(string: String) -> UILabel {
        let column = UILabel()
        column.text = string
        column.font = .systemFont(ofSize: 24)
        column.textColor = .black
        column.backgroundColor = .gray
        column.translatesAutoresizingMaskIntoConstraints = false
        column.textAlignment = .left
        
        column.widthAnchor.constraint(equalToConstant: 368).isActive = true
        column.heightAnchor.constraint(equalToConstant: 63).isActive = true
        
        return column
    }
    
}
