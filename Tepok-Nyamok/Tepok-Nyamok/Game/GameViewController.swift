//
//  GameViewController.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the SKView
        let skView = SKView(frame: view.bounds)
        skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(skView)
        
        // Create and configure the scene
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        
        // Present the scene in the SKView
        skView.presentScene(scene)
        
        // Additional configuration for the SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}

