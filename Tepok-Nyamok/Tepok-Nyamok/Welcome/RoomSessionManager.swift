//
//  RoomSessionManager.swift
//  Tepok-Nyamok
//
//  Created by Leonardo Wijaya on 22/05/23.
//

import MultipeerConnectivity

class RoomSessionManager: NSObject, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate {
    
    private var serviceType = "tepok"
    private var peerID: MCPeerID!
    private var session: MCSession!
    private var browser: MCBrowserViewController!
    private var advertiser: MCAdvertiserAssistant!
    
    var player: Player?
    
    override init() {
        super.init()
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        
        advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: session)
        
        browser = MCBrowserViewController(serviceType: serviceType, session: session)
        browser.delegate = self
    }
    
    func startAdvertising() {
        advertiser.start()
    }
    
    func stopAdvertising() {
        advertiser.stop()
    }
    
    func showBrowserViewController(from viewController: UIViewController) {
        viewController.present(browser, animated: true, completion: nil)
    }
    
    // MARK: AdvertiserDelegate
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, self.session)
    }
    
    // MARK: MCSessionDelegate
    
    // Called when a remote peer opens a stream to the local peer
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Handle incoming stream
        print(#function)
    }
    
    // Called when a remote peer sends an NSData object to the local peer
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // Handle incoming data
        print(#function)
    }
    
    // Called when a remote peer sends a resource at a URL to the local peer
    func session(_ session: MCSession, didReceiveResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        // Handle incoming resource
        print(#function)
    }
    
    // Called when the local peer starts receiving a resource from a remote peer
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Handle resource reception progress
        print(#function)
    }
    
    // Called when the local peer finishes receiving a resource from a remote peer
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Handle resource reception completion
        print(#function)
    }
    
    // Called when a connected peer changes state (e.g., goes offline)
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        // Handle peer state change
        switch state {
        case .connected: print("Connected \(peerID)")
        case .connecting: print("Connecting \(peerID)")
        case .notConnected: print("Not connected \(peerID)")
        default: print("Unknown status for \(peerID)")
        }
    }
    
    // MARK: MCBrowserViewControllerDelegate
    
    // Called when the user taps the done button in the browser view controller
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browser.dismiss(animated: true, completion: nil)
        print(#function)
    }
    
    // Called when the user taps the cancel button in the browser view controller
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browser.dismiss(animated: true, completion: nil)
        print(#function)
    }
    
    
    
}
