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
    func gameKitManagerDidJoinSession()
    func gameKitManagerDidFailToJoinSessionWithError(_ error: Error)
    func gameKitManagerDidReceiveData(_ data: Data, fromPlayer player: GKPlayer)
}

enum GameKitError: Error {
    case noCurrentSession
    case noCurrentParticipant
    case noNextParticipant
    case notLocalPlayerTurn
}

class GameKitManager: NSObject, UINavigationControllerDelegate {

    static let shared = GameKitManager()

    weak var delegate: GameKitManagerDelegate?
    let localPlayer = GKLocalPlayer.local
    private var multiplayerEnabled = false
    var currentSession: GKMatch?

    private override init() {
        super.init()
    }

    // MARK: GameKitManager
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
                self.createPlayer()
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

        let matchRequest = GKMatchRequest()
        matchRequest.minPlayers = 2
        matchRequest.maxPlayers = 5

        let viewController = GKMatchmakerViewController(matchRequest: matchRequest)
        viewController?.delegate = self
        viewController?.matchmakerDelegate = self

        if let topViewController = UIApplication.shared.windows.first?.rootViewController?.topVisibleViewController {
            topViewController.present(viewController!, animated: true, completion: nil)
        } else {
            print("Unable to present GKMatchmakerViewController: top visible view controller not found")
        }
    }

    func sendGameData(_ data: Data) {
        guard let match = currentSession else {
            print("No current match session")
            return
        }
        
        do {
            try match.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("Failed to send game data:", error)
        }
    }

    private func createPlayer() {
        let name = localPlayer.displayName
        self.player = Player(name: name)
    }

    func passTurnToNextParticipant(completion: @escaping (Error?) -> Void) {
        
    }

    // MARK: GameController
    var player: Player?
    var playingGame = false
    var myTurn = false
    
    var youWon = false
    var youLost = false
    
    var players: [GKPlayer]?
    var count: Int?
    
    func startMatch() {
        count = 0
        playingGame = true
        
        players = currentSession?.players
        determineFirstPlayer(excluding: [GKLocalPlayer.local])
        if determineFirstPlayer(excluding: [GKLocalPlayer.local]) == GKLocalPlayer.local {
            myTurn = true
            
        }
        
    }
    
    func determineFirstPlayer(excluding excludedPlayers: [GKPlayer]) -> GKPlayer? {
        let eligiblePlayers = players?.filter { !excludedPlayers.contains($0) }
        let sortedPlayers = eligiblePlayers?.sorted { $0.playerID < $1.playerID }
        return sortedPlayers?.first
    }
    
}

extension GameKitManager: GKMatchmakerViewControllerDelegate {
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
        delegate?.gameKitManagerDidFailToJoinSessionWithError(error)
    }

    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true, completion: nil)
        self.currentSession = match
        match.delegate = self
        delegate?.gameKitManagerDidJoinSession()
        startMatch()
    }
}

extension GameKitManager: GKMatchDelegate {
    
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        //
    }
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        //
    }
    
    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return false
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
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
