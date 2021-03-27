//
//  ProductivityScene.swift
//  Work Hard Play Hard
//
//  Created by Eric Corpuz on 2021-03-27.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ProductivityScene: SKScene, UITextFieldDelegate{
    
    var lblTitle = SKLabelNode()
    var lblSignUp = SKLabelNode()
    var lblLogin = SKLabelNode()
    var lblStress = SKLabelNode()
    // let submitScore = SKSpriteNode(imageNamed: "button")
    let submitTxtUserName = SKLabelNode(fontNamed: "arial")
    let submitTxtUserNameShadow = SKLabelNode(fontNamed: "arial")
    var txtProductive: UITextField!
    
    let submitTxtPassword = SKLabelNode(fontNamed: "arial")
    let submitTxtPasswordShadow = SKLabelNode(fontNamed: "arial")
    var txtAddGoal: UITextField!
    
    
//    let winner = SKLabelNode(fontNamed: "Chalkduster")
//    winner.text = "You Win!"
//    winner.fontSize = 65
//    winner.fontColor = SKColor.green
//    winner.position = CGPoint(x: frame.midX, y: frame.midY)
//
//    addChild(winner)
    
    override func didMove( to view: SKView){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //adding the Sprite Kit nodes to the Scene
        lblTitle = self.childNode(withName: "lblTitle") as! SKLabelNode
        lblSignUp = self.childNode(withName: "lblGuide") as! SKLabelNode
        lblLogin = self.childNode(withName: "lblStatus") as! SKLabelNode
        lblStress = self.childNode(withName: "lblStress") as! SKLabelNode
        
        
        //Setting position of UIKit elements
       
        
        
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let touchLocation = t.location(in: self)
            
            if atPoint(touchLocation).name == "lblStress"{
               // txtUserName.removeFromSuperview()
              //  txtPassword.removeFromSuperview()

              

              
            
                let gameScene = SKScene(fileNamed: "ProductivityMainScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }
            
            //Navigation to TimerScene when user clicks Login
            if atPoint(touchLocation).name == "lblLogin"{
               // txtUserName.removeFromSuperview()
              //  txtPassword.removeFromSuperview()

                let gameScene = SKScene(fileNamed: "LoginScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }
        }
    }
}
    

