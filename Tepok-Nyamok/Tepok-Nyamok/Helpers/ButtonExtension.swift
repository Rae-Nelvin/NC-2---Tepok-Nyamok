//
//  ButtonExtension.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit

extension UIButton {
    
    func generateButton(string: String, tag: Int) -> UIButton {
        self.setTitle(string, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 34, weight: .bold)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 368).isActive = true
        self.heightAnchor.constraint(equalToConstant: 74).isActive = true
        self.tag = tag
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 255)
        self.layer.borderWidth = 1
        
        return self
    }
    
    func generateExitButton() -> UIButton {
        self.setTitle("Exit", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 28)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 83).isActive = true
        self.heightAnchor.constraint(equalToConstant: 42).isActive = true
        self.tag = tag
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 255)
        self.layer.borderWidth = 1
        
        return self
    }
    
}
