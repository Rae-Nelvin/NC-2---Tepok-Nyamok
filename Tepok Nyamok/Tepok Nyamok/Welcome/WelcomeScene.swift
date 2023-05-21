import SpriteKit
import GameplayKit

class WelcomeScene: SKScene {

    private var titleLabel: SKLabelNode!
    private var roundedRectangle: SKShapeNode!
    private var startButton: SKShapeNode!
    private var hostSessionButton: SKShapeNode!
    private var joinSessionButton: SKShapeNode!
    private var nameTextField: UITextField!
    private var playerName: String?
    private var joinButton: SKShapeNode!
    
    enum ButtonStage {
        case start
        case hostJoin
        case join
    }
    
    private var currentButtonStage: ButtonStage = .start

    override func sceneDidLoad() {
        self.backgroundColor = UIColor(named: "Cream-Yellow") ?? .white

        titleLabel = SKLabelNode(text: "Tepok Nyamok")
        titleLabel.fontName = "Helvetica-Bold"
        titleLabel.fontSize = 48
        titleLabel.numberOfLines = 41
        titleLabel.position = CGPoint(x: size.width/2, y: size.height - 153)
        addChild(titleLabel)

        let rectangleSize = CGSize(width: 368, height: 368)
        roundedRectangle = SKShapeNode(rectOf: rectangleSize, cornerRadius: 10)
        roundedRectangle.fillColor = UIColor.gray
        roundedRectangle.position = CGPoint(x: size.width / 2, y: size.height / 2 + 50)
        addChild(roundedRectangle)

        createNameTextField()

        startButton = roundedButton(color: UIColor.gray)
        startButton.position = CGPoint(x: size.width / 2, y: 111)
        addChild(startButton)

        let startLabel = addLabelToButton(text: "Start")
        startButton.addChild(startLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            switch currentButtonStage {
            case .start:
                if startButton.contains(location) {
                    animateFadeInAndFadeOutStart()
                    savePlayerName()
                    currentButtonStage = .hostJoin
                }
            case .hostJoin:
                if hostSessionButton.contains(location) {
                    self.animateFadeInAndFadeOutHost()
                    let playersScene = PlayerScene(size: self.size)
                    playersScene.scaleMode = self.scaleMode
                    self.view?.presentScene(playersScene)
                } else if joinSessionButton.contains(location) {
                    self.animateFadeInAndFadeOutJoin()
                    currentButtonStage = .join
                }
            case .join:
                if joinButton.contains(location) {
                    // Handle the join button press
                    print("Join pressed")
                }
            }
        }
    }

    private func savePlayerName() {
        guard let name = playerName else { return }

        // Perform any necessary actions with the player's name, such as saving it to a data structure or game manager
        print("Player's Name: \(name)")
    }

    private func roundedButton(color: UIColor) -> SKShapeNode {
        let cornerRadius: CGFloat = 10
        let borderWidth: CGFloat = 1
        let size: CGSize = CGSize(width: 368, height: 74)

        let roundedRect = CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)

        let button = SKShapeNode(path: path.cgPath)
        button.fillColor = color
        button.strokeColor = .white
        button.lineWidth = borderWidth

        return button
    }

    private func createNameTextField() {
        let textFieldSize = CGSize(width: 368, height: 58)

        nameTextField = UITextField(frame: CGRect(origin: .zero, size: textFieldSize))
        nameTextField.center = CGPoint(x: self.size.width / 2, y: self.size.height - 170)
        nameTextField.placeholder = "Enter your name"
        nameTextField.textAlignment = .center
        nameTextField.borderStyle = .roundedRect
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.delegate = self

        self.view?.addSubview(nameTextField)
    }

    private func addLabelToButton(text: String) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontName = "Helvetica-Bold"
        label.fontSize = 34
        label.position = CGPoint(x: 0, y: -10)

        return label
    }

    private func animateFadeInAndFadeOutStart() {
        let fadeOutDuration: TimeInterval = 0.2
        let fadeInDuration: TimeInterval = 0.2

        let fadeOutAction = SKAction.fadeOut(withDuration: fadeOutDuration)
        startButton.run(fadeOutAction) {
            self.startButton.removeFromParent()
            self.showHostAndJoinButtons()

            self.hostSessionButton.alpha = 0
            self.joinSessionButton.alpha = 0
            let fadeInAction = SKAction.fadeIn(withDuration: fadeInDuration)
            self.hostSessionButton.run(fadeInAction)
            self.joinSessionButton.run(fadeInAction)
        }
    }

    private func animateFadeInAndFadeOutJoin() {
        let fadeOutDuration: TimeInterval = 0.2
        let fadeInDuration: TimeInterval = 0.2

        let fadeOutAction = SKAction.fadeOut(withDuration: fadeOutDuration)
        joinSessionButton.run(fadeOutAction) {
            self.hostSessionButton.removeFromParent()
            self.joinSessionButton.removeFromParent()
            self.showJoinSession()

            self.joinButton.alpha = 0
            let fadeInAction = SKAction.fadeIn(withDuration: fadeInDuration)
            self.joinButton.run(fadeInAction)
        }
    }

    private func animateFadeInAndFadeOutHost() {
        let fadeOutDuration: TimeInterval = 0.2
        let fadeInDuration: TimeInterval = 0.2

        let fadeOutAction = SKAction.fadeOut(withDuration: fadeOutDuration)
        hostSessionButton.run(fadeOutAction) {
            self.hostSessionButton.removeFromParent()
            self.joinSessionButton.removeFromParent()
            self.showJoinSession()

            self.joinButton.alpha = 0
            let fadeInAction = SKAction.fadeIn(withDuration: fadeInDuration)
            self.joinButton.run(fadeInAction)
        }
    }

    private func showHostAndJoinButtons() {
        hostSessionButton = roundedButton(color: UIColor.gray)
        hostSessionButton.position = CGPoint(x: size.width / 2, y: 201)
        addChild(hostSessionButton)

        let hostSessionLabel = addLabelToButton(text: "Host a Session")
        hostSessionButton.addChild(hostSessionLabel)

        joinSessionButton = roundedButton(color: UIColor.gray)
        joinSessionButton.position = CGPoint(x: size.width / 2, y: 100)
        addChild(joinSessionButton)

        let joinSessionLabel = addLabelToButton(text: "Join a Session")
        joinSessionButton.addChild(joinSessionLabel)
    }

    private func showJoinSession() {
        joinButton = roundedButton(color: UIColor.gray)
        joinButton.position = CGPoint(x: size.width / 2, y: 111)
        addChild(joinButton)

        let joinLabel = addLabelToButton(text: "Join")
        joinButton.addChild(joinLabel)
    }
}

extension WelcomeScene: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
