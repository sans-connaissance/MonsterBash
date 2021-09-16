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
    var coin1: SKSpriteNode!
    var coin2: SKSpriteNode!
    
    var coin1Label: SKLabelNode!
    var coin2Label: SKLabelNode!
    
    // Buttons
    var quirkButton: ButtonNode!
    var zapButton: ButtonNode!
    var munchButton: ButtonNode!
    
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        
        print("scene size: \(size)")
        
        // Start background music
        let bgMusic = SKAudioNode(fileNamed: "Latin_Industries.mp3")
        bgMusic.autoplayLooped = true
        addChild(bgMusic)
        
        // bacground image
        background = (self.childNode(withName: "background") as! SKSpriteNode)
        
        coin1 = (self.childNode(withName: "coin1") as! SKSpriteNode)
        coin1Label = (self.childNode(withName: "coin1Label") as! SKLabelNode)
        
        coin2 = (self.childNode(withName: "coin2") as! SKSpriteNode)
        coin2Label = (self.childNode(withName: "coin2Label") as! SKLabelNode)
        
        quirkButton = ButtonNode(iconName: "quirk1", text: "10", onButtonPress: quirkPressed)
        quirkButton.position = CGPoint(x: -350, y: -275)
        addChild(quirkButton)
        
        // Add zap button
        zapButton = ButtonNode(iconName: "zap1", text: "25", onButtonPress: zapPressed)
        zapButton.position = CGPoint(x: 0, y: -275)
        addChild(zapButton)
        
        // Add munch button
        munchButton = ButtonNode(iconName: "munch1", text: "50", onButtonPress: munchPressed)
        munchButton.position = CGPoint(x: 350, y: -275)
        addChild(munchButton)
        
        
        // Adding and managing entities
        entityManager = EntityManager(scene: self)
        
        let humanCastle = Castle(imageName: "castle1_atk", team: .team1, entityManager: entityManager)
        if let spriteComponent = humanCastle.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: -500, y: 50)
        }
        entityManager.add(humanCastle)
        
        
        let aiCastle = Castle(imageName: "castle2_atk", team: .team2, entityManager: entityManager)
        if let spriteComponent = aiCastle.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: 500, y: 50)
        }
        entityManager.add(aiCastle)
        
    }
    
    func quirkPressed() {
        entityManager.spawnQuirk(team: .team1)
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
        
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entityManager.update(deltaTime)
        
        if let human = entityManager.castle(for: .team1),
           let humanCastle = human.component(ofType: CastleComponent.self) {
            coin1Label.text = "\(humanCastle.coins)"
        }
        if let ai = entityManager.castle(for: .team2),
           let aiCastle = ai.component(ofType: CastleComponent.self) {
            coin2Label.text = "\(aiCastle.coins)"
        }
    }
}

