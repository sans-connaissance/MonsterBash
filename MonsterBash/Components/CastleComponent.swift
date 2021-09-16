//
//  CastleComponent.swift
//  MonsterBash
//
//  Created by David Malicke on 9/15/21.
//

import GameplayKit
import SpriteKit

class CastleComponent: GKComponent {
    
    
    var coins = 0
    var lastCoinDrop = TimeInterval(0)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        let coinDropInterval = TimeInterval(0.5)
     //   let coinDropInterval = TimeInterval(10.0)
        let coinsPerInterval = 10
        if (CACurrentMediaTime() - lastCoinDrop > coinDropInterval) {
            lastCoinDrop = CACurrentMediaTime()
            coins += coinsPerInterval
        }
    }
}
