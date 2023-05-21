//
//  WelcomeViewController.swift
//  Tepok Nyamok
//
//  Created by Leonardo Wijaya on 19/05/23.
//

import UIKit
import SpriteKit
import GameplayKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = WelcomeScene(size: view.bounds.size)
        let skView = SKView(frame: view.bounds)
        view.addSubview(skView)
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
    }
    
}
