//
//  Castle.swift
//  MonsterBash
//
//  Created by David Malicke on 9/14/21.
//
import GameplayKit
import SpriteKit

class Castle: GKEntity {
    
    init(imageName: String, team: Team, entityManager: EntityManager) {
        super.init()
        
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(CastleComponent())
        addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
