import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Constants
    let margin = CGFloat(30)
    
    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    // Game over detection
    var gameOver = false
    
    // Graphical elements
    var background: SKSpriteNode!
    var quirkButton: ButtonNode!
    
    override func didMove(to view: SKView) {
        
        print("scene size: \(size)")
        
        // Start background music
        let bgMusic = SKAudioNode(fileNamed: "Latin_Industries.mp3")
        bgMusic.autoplayLooped = true
        addChild(bgMusic)
        
        // bacground image
        background = (self.childNode(withName: "background") as! SKSpriteNode)
        
        quirkButton = ButtonNode(iconName: "quirk1", text: "10", onButtonPress: quirkPressed)
        quirkButton.position = CGPoint(x: -364, y: -275)
        addChild(quirkButton)
        
        
        
    }
    
    func quirkPressed() {
        print("Quirk pressed!")
    }
    
    func zapPressed() {
        print("Zap pressed!")
    }
    
    func munchPressed() {
        print("Munch pressed!")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        if gameOver {
            let newScene = GameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
        
    }
    
    func showRestartMenu(_ won: Bool) {
        
        if gameOver {
            return;
        }
        gameOver = true
        
        let message = won ? "You win" : "You lose"
        
        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 100
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = message
        label.setScale(0)
        addChild(label)
        
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        scaleAction.timingMode = SKActionTimingMode.easeInEaseOut
        label.run(scaleAction)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if gameOver {
            return
        }
        
    }
}

