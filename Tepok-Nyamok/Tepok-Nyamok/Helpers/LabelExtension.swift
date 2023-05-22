//
//  LabelExtension.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit

extension UILabel {
    
    func generateText(string: String, fontSize: CGFloat, fontWeight: UIFont.Weight) -> UILabel {
        self.text = string
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self
    }
    
}
