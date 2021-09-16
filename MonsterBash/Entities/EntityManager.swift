//
//  EntityManager.swift
//  MonsterBash
//
//  Created by David Malicke on 9/14/21.
//

import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    lazy var componentSystems: [GKComponentSystem] = {
      let castleSystem = GKComponentSystem(componentClass: CastleComponent.self)
      return [castleSystem]
    }()
    
    var toRemove = Set<GKEntity>()
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
            
            for componentSystem in componentSystems {
              componentSystem.addComponent(foundIn: entity)
            }
        }
    }
    
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
      for componentSystem in componentSystems {
        componentSystem.update(deltaTime: deltaTime)
      }

      for currentRemove in toRemove {
        for componentSystem in componentSystems {
          componentSystem.removeComponent(foundIn: currentRemove)
        }
      }
      toRemove.removeAll()
    }
    
    func castle(for team: Team) -> GKEntity? {
      for entity in entities {
        if let teamComponent = entity.component(ofType: TeamComponent.self),
          let _ = entity.component(ofType: CastleComponent.self) {
          if teamComponent.team == team {
            return entity
          }
        }
      }
      return nil
    }
    
    func spawnQuirk(team: Team) {
 
      guard let teamEntity = castle(for: team),
        let teamCastleComponent = teamEntity.component(ofType: CastleComponent.self),
        let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
          return
      }


      if teamCastleComponent.coins < costQuirk {
        return
      }
      teamCastleComponent.coins -= costQuirk
      scene.run(SoundManager.sharedInstance.soundSpawn)


      let monster = Quirk(team: team)
      if let spriteComponent = monster.component(ofType: SpriteComponent.self) {
        spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: 50, max: 500))
        spriteComponent.node.zPosition = 2
      }
      add(monster)
    }
    
}
