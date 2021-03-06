//
//  MoveComponent.swift
//  MonsterBash
//
//  Created by David Malicke on 9/15/21.
//

import SpriteKit
import GameplayKit

// 1
class MoveComponent: GKAgent2D, GKAgentDelegate {

  // 2
  let entityManager: EntityManager

  // 3
  init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
    self.entityManager = entityManager
    super.init()
    delegate = self
    self.maxSpeed = maxSpeed
    self.maxAcceleration = maxAcceleration
    self.radius = radius
    print(self.mass)
    self.mass = 0.01
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // 4
  func agentWillUpdate(_ agent: GKAgent) {
    guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
      return
    }

    position = SIMD2<Float>(spriteComponent.node.position)
  }

  // 5
  func agentDidUpdate(_ agent: GKAgent) {
    guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
      return
    }

    spriteComponent.node.position = CGPoint(position)
  }
    
    func closestMoveComponent(for team: Team) -> GKAgent2D? {

      var closestMoveComponent: MoveComponent? = nil
      var closestDistance = CGFloat(0)

      let enemyMoveComponents = entityManager.moveComponents(for: team)
      for enemyMoveComponent in enemyMoveComponents {
        let distance = (CGPoint(enemyMoveComponent.position) - CGPoint(position)).length()
        if closestMoveComponent == nil || distance < closestDistance {
          closestMoveComponent = enemyMoveComponent
          closestDistance = distance
        }
      }
      return closestMoveComponent
      
    }
    
    override func update(deltaTime seconds: TimeInterval) {
      super.update(deltaTime: seconds)

      // 1
      guard let entity = entity,
        let teamComponent = entity.component(ofType: TeamComponent.self) else {
          return
      }

      // 2
      guard let enemyMoveComponent = closestMoveComponent(for: teamComponent.team.oppositeTeam()) else {
        return
      }

      // 3
      let alliedMoveComponents = entityManager.moveComponents(for: teamComponent.team)

      // 4
      behavior = MoveBehavior(targetSpeed: maxSpeed, seek: enemyMoveComponent, avoid: alliedMoveComponents)
    }
}
