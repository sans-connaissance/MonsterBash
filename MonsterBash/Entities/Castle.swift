//
//  Castle.swift
//  MonsterBash
//
//  Created by David Malicke on 9/14/21.
//
import GameplayKit
import SpriteKit

class Castle: GKEntity {
    
    init(imageName: String) {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
