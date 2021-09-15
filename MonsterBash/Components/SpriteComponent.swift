//
//  SpriteComponent.swift
//  MonsterBash
//
//  Created by David Malicke on 9/14/21.
//

import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {
    
    let node: SKSpriteNode
    
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
