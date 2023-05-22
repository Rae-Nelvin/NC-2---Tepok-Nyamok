//
//  PlayersScene.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 21/05/23.
//

import UIKit

class PlayersScreen: UIViewController {
    
    private var rsm: RoomSessionManager = RoomSessionManager()
    private var titleLabel = UILabel()
    private var players: [String] = ["Player 1", "Player2", "Player 3", "Player 4", "Player 5"]
    private var playerColumn = UILabel()
    private var startButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel = UILabel().generateText(string: "Players 1/5", fontSize: 28, fontWeight: .regular)
        view.addSubview(titleLabel)
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        addPlayerNames()
        
        startButton = UIButton().generateButton(string: "Start", tag: 1)
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func addPlayerNames() {
        for playerName in players {
            let playerNameView = generateColumn(string: playerName)
            stackView.addArrangedSubview(playerNameView)
        }
    }
    
    private func generateColumn(string: String) -> UIView {
        let column = UIView()
        column.backgroundColor = .gray
        column.layer.cornerRadius = 10
        column.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(column)
        
        let label = UILabel()
        label.text = string
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        column.addSubview(label)
        
        NSLayoutConstraint.activate([
            column.widthAnchor.constraint(equalToConstant: 368),
            column.heightAnchor.constraint(equalToConstant: 63),
            
            label.centerYAnchor.constraint(equalTo: column.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: column.leadingAnchor, constant: 29)
        ])
        
        return column
    }
    
}
