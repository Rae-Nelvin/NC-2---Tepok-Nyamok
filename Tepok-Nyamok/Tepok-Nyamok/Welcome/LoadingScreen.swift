//
//  LoadingScreen.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 23/05/23.
//

import UIKit
import GameKit

class LoadingScreen: UIViewController {
    private let gameKitManager = GameKitManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameKitManager.delegate = self
        startLoading()
    }
    
    private func startLoading() {
        showLoadingIndicator()
        gameKitManager.authenticateLocalPlayer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Adjust the timeout duration as needed
            if self.gameKitManager.player != nil {
                self.loadingComplete()
            } else {
                self.showTimeoutError()
            }
        }
    }
    
    private func showLoadingIndicator() {
        // Display loading indicator UI
        view.backgroundColor = UIColor(named: "Cream-Yellow")
        
    }
    
    private func loadingComplete() {
        // Loading is complete, proceed to the next screen
        let welcomeScreen = WelcomeScreen()
        welcomeScreen.modalPresentationStyle =  .fullScreen
        self.present(welcomeScreen, animated: true, completion: nil)
    }
    
    private func showTimeoutError() {
        // Display timeout error UI
    }
    
    private func showAuthenticationError() {
        
    }
}

extension LoadingScreen: GameKitManagerDelegate {
    func gameKitManagerDidCreateSession() {
        //
    }
    
    func gameKitManagerDidFailToCreateSessionWithError(_ error: Error) {
        //
    }
    
    func gameKitManagerDidJoinSession() {
        //
    }
    
    func gameKitManagerDidFailToJoinSessionWithError(_ error: Error) {
        //
    }
    
    func gameKitManagerDidReceiveData(_ data: Data, fromPlayer player: GKPlayer) {
        //
    }
    
    func gameKitManagerDidAuthenticate() {
        // Player authentication is successful, proceed with loading
        if gameKitManager.player != nil {
            loadingComplete()
        }
    }
    
    func gameKitManagerDidFailToAuthenticateWithError(_ error: Error) {
        // Display authentication error UI
        showAuthenticationError()
    }
    
    // Implement other delegate methods as needed
}

