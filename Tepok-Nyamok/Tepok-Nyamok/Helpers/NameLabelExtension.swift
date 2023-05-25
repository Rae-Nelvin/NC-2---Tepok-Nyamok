//
//  NameLabelExtension.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 25/05/23.
//

import UIKit

extension UIView {
    
    func generateNameLabel(string: String, fontSize: CGFloat, fontWeight: UIFont.Weight) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: "Orange")
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 255)
        containerView.layer.borderWidth = 1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = string
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 368),
            containerView.heightAnchor.constraint(equalToConstant: 74),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        return containerView
    }
    
}
