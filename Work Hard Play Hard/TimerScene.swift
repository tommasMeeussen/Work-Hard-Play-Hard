//
//  TimerScene.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-03-24.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TimerScene: SKScene, UITextFieldDelegate{
    
    var lblTimerTitle = SKLabelNode()
    var lblTimer = SKLabelNode()
    var lblStartTimer = SKLabelNode()
    var lblPauseTimer = SKLabelNode()
    var lblStopTimer = SKLabelNode()
    var lblStartGame = SKLabelNode()
    var lblProductive = SKLabelNode()
    
     override func didMove( to view: SKView){
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            lblTimerTitle = self.childNode(withName: "lblTimerTitle") as! SKLabelNode

            lblTimer = self.childNode(withName: "lblTimer") as! SKLabelNode
            
            lblStartTimer = self.childNode(withName: "lblStartTimer") as! SKLabelNode
            
            lblPauseTimer = self.childNode(withName: "lblPauseTimer") as! SKLabelNode
            
            lblStopTimer = self.childNode(withName: "lblStopTimer") as! SKLabelNode
            
            lblStartGame = self.childNode(withName: "lblStartGame") as! SKLabelNode
        
        lblProductive = self.childNode(withName: "lblProductive") as! SKLabelNode

            
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let touchLocation = t.location(in: self)
            
            //Navigation to TimerScene when user clicks Login
            if atPoint(touchLocation).name == "lblStartGame"{
               

                let gameScene = SKScene(fileNamed: "GameScene")
                gameScene?.size = self.view?.bounds.size as! CGSize
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }
            
            if atPoint(touchLocation).name == "lblProductive"{
               

                let gameScene = SKScene(fileNamed: "ProductivityScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }

        }
    }
    
    
}
