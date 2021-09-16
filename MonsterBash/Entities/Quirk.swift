//
//  Quirk.swift
//  MonsterBash
//
//  Created by David Malicke on 9/15/21.
//

import SpriteKit
import GameplayKit

class Quirk: GKEntity {

  init(team: Team) {
    super.init()
    let texture = SKTexture(imageNamed: "quirk\(team.rawValue)")
    let spriteComponent = SpriteComponent(texture: texture)
    addComponent(spriteComponent)
    addComponent(TeamComponent(team: team))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
