//
//  ViewController.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 21/05/23.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    private var titleLabel = UILabel()
    private var startButton = UIButton(type: .system)
    private var nameTextField: UITextField!
    private var rectangle: UIView = UIView()
    private var playerName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        titleLabel = generateText(string: "Tepok Nyamok", fontSize: 48, fontWeight: .black)
        view.addSubview(titleLabel)
        
        rectangle.backgroundColor = .gray
        rectangle.layer.cornerRadius = 10
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rectangle)
        
        nameTextField = generateTextField(string: "Input your name...")
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view.addSubview(nameTextField)
        
        startButton = generateButton(string: "Start")
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.isEnabled = false
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rectangle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37),
            rectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangle.widthAnchor.constraint(equalToConstant: 368),
            rectangle.heightAnchor.constraint(equalToConstant: 368),
            
            nameTextField.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 38),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 32),
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
    
    private func generateButton(string: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(string, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 368).isActive = true
        button.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        return button
    }
    
    private func generateTextField(string: String) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.attributedPlaceholder = NSAttributedString (
            string: string,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "Arial", size: 20)!
            ]
        )
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 27, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.widthAnchor.constraint(equalToConstant: 368).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        return textField
    }
    
    private func showOtherButtons() {
        let hostSessionButton = generateButton(string: "Host a Session")
        let joinSessionButton = generateButton(string: "Join a Session")
        
        hostSessionButton.alpha = 0
        joinSessionButton.alpha = 0
        
        view.addSubview(hostSessionButton)
        view.addSubview(joinSessionButton)
        
        NSLayoutConstraint.activate([
            hostSessionButton.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 38),
            hostSessionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            joinSessionButton.topAnchor.constraint(equalTo: hostSessionButton.bottomAnchor, constant: 27),
            joinSessionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        UIView.animate(withDuration: 0.5) {
            hostSessionButton.alpha = 1
            joinSessionButton.alpha = 1
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            playerName = text
            startButton.isEnabled = true
        } else {
            playerName = nil
            startButton.isEnabled = false
        }
    }
    
    @objc private func startButtonTapped() {
        guard let name = playerName else { return }
        print("Player's Name: \(name)")
        
        UIView.animate(withDuration: 0.3, animations: {
            self.nameTextField.alpha = 0
            self.startButton.alpha = 0
        }) { _ in
            self.nameTextField.removeFromSuperview()
            self.startButton.removeFromSuperview()
            self.showOtherButtons()
        }
    }
}

