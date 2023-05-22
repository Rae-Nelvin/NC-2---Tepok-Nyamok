//
//  TextFieldExtension.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit

extension UITextField {
    
    func generateTextField(string: String) -> UITextField {
        self.backgroundColor = .gray
        self.attributedPlaceholder = NSAttributedString (
            string: string,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "Arial", size: 20)!
            ]
        )
        self.borderStyle = .roundedRect
        self.autocorrectionType = .no
        self.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 27, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.widthAnchor.constraint(equalToConstant: 368).isActive = true
        self.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        return self
    }
    
}
