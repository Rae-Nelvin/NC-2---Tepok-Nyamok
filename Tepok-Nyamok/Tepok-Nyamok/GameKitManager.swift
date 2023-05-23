//
//  GameKitManager.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 23/05/23.
//

import Foundation
import GameKit

protocol GameKitManagerDelegate: AnyObject {
    func gameKitManagerDidAuthenticate()
    func gameKitManagerDidFailToAuthenticateWithError(_ error: Error)
    func gameKitManagerDidCreateSession()
    func gameKitManagerDidFailToCreateSessionWithError(_ error: Error)
    func gameKitManagerDidJoinSession()
    func gameKitManagerDidFailToJoinSessionWithError(_ error: Error)
    func gameKitManagerDidReceiveData(_ data: Data, fromPlayer player: GKPlayer)
}

class GameKitManager: NSObject {
    static let shared = GameKitManager()
    
    weak var delegate: GameKitManagerDelegate?
    private let localPlayer = GKLocalPlayer.local
    private var multiplayerEnabled = false
    private var currentSession: GKMatch?
    var player: Player?
    
    
    private override init() {
        super.init()
    }
    
    func authenticateLocalPlayer() {
        guard !multiplayerEnabled else {
            return
        }
        
        localPlayer.authenticateHandler = { [weak self] viewController, error in
            guard let self = self else { return }
            
            if let viewController = viewController {
                self.presentAuthenticationViewController(viewController)
            } else if let error = error {
                self.delegate?.gameKitManagerDidFailToAuthenticateWithError(error)
            } else if self.localPlayer.isAuthenticated {
                self.multiplayerEnabled = true
                self.delegate?.gameKitManagerDidAuthenticate()
                createPlayer()
            }
        }
    }
    
    private func presentAuthenticationViewController(_ viewController: UIViewController) {
        // Present the Game Center authentication view controller
        // in your UIViewController or UIWindow
    }
    
    func createSession() {
        guard multiplayerEnabled else {
            return
        }
        
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 5
        
        let matchMakerViewController = GKMatchmakerViewController(matchRequest: request)
        matchMakerViewController?.matchmakerDelegate = self
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController?.topVisibleViewController {
            topViewController.present(matchMakerViewController!, animated: true, completion: nil)
        } else {
            print("Unable to present GKMatchmakerViewController: top visible view controller not found")
        }
    }
    
    func joinSession() {
        guard multiplayerEnabled else {
            return
        }
        
        let matchRequest = GKMatchRequest()
        matchRequest.minPlayers = 2
        matchRequest.maxPlayers = 5
        
        let matchMakerViewController = GKMatchmakerViewController(matchRequest: matchRequest)
        matchMakerViewController?.matchmakerDelegate = self
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController?.topVisibleViewController {
            topViewController.present(matchMakerViewController!, animated: true, completion: nil)
        } else {
            print("Unable to present GKMatchmakerViewController: top visible view controller not found")
        }
    }
    
    func sendGameData(_ data: Data) {
        guard let session = currentSession else {
            return
        }
        
        do {
            try session.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("Failed to send data: \(error)")
        }
    }
    
    private func createPlayer() {
        let name = localPlayer.displayName
        self.player = Player(name: name)
    }
}

extension GameKitManager: GKMatchmakerViewControllerDelegate {
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true, completion: nil)
        currentSession = match
        match.delegate = self
        delegate?.gameKitManagerDidJoinSession()
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
        delegate?.gameKitManagerDidFailToJoinSessionWithError(error)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

extension GameKitManager: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromPlayer player: GKPlayer) {
        delegate?.gameKitManagerDidReceiveData(data, fromPlayer: player)
    }
}

extension UIViewController {
    var topVisibleViewController: UIViewController? {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topVisibleViewController
        }
        
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topVisibleViewController
        }
        
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topVisibleViewController
        }
        
        return self
    }
}

