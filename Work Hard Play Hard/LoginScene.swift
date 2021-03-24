//
//  LoginScene.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-03-24.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import SpriteKit

class LoginScene: SKScene{
    
    var lblTitle = SKLabelNode()
    
    
    override func didMove( to view: SKView){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        lblTitle = self.childNode(withName: "lblTitle") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let touchLocation = t.location(in: self)
            
            if atPoint(touchLocation).name == "lblTitle"{
                let gameScene = SKScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
            }
        }
    }
}
