//
//  ProductivityMainScene.swift
//  Work Hard Play Hard
//
//  Created by Eric Corpuz on 2021-03-27.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ProductivityMainScene: SKScene, UITextFieldDelegate{
    
    var lblTitle = SKLabelNode()
    var lblSignUp = SKLabelNode()
    var lblLogin = SKLabelNode()

    // let submitScore = SKSpriteNode(imageNamed: "button")
    let submitTxtProductive = SKLabelNode(fontNamed: "arial")
    let submitTxtUserNameShadow = SKLabelNode(fontNamed: "arial")
    var txtProductive: UITextField!
    
    let submitTxtAddGoal = SKLabelNode(fontNamed: "arial")
    let submitTxtPasswordShadow = SKLabelNode(fontNamed: "arial")
    
    let submitTxtManageWorkLoad = SKLabelNode(fontNamed: "arial")
    let submitTxtManageWorkLoadShadow = SKLabelNode(fontNamed: "arial")
    var txtAddGoal: UITextField!
    var txtManageWorkLoad: UITextField!
    
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
       
        
        
        txtProductive = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 120, width: 320, height: 40))

        txtAddGoal = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 70, width: 320, height: 40))
        txtManageWorkLoad = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))

        
        // adding subview of the UITextField's to the GameScene's view
        view.addSubview(txtProductive)
        view.addSubview(txtAddGoal)
        view.addSubview(txtManageWorkLoad)

        //Setting Properties of text field txtPassword
        txtProductive.delegate = self

        txtProductive.borderStyle = UITextField.BorderStyle.roundedRect
        txtProductive.textColor = SKColor.black
            txtProductive.placeholder = "Write Current Mood"
        txtProductive.backgroundColor = SKColor.white
        txtProductive.autocorrectionType = UITextAutocorrectionType.yes

        txtProductive.clearButtonMode = UITextField.ViewMode.whileEditing
        txtProductive.autocapitalizationType = UITextAutocapitalizationType.allCharacters
            self.view!.addSubview(txtProductive)

            submitTxtProductive.fontSize = 22
            submitTxtProductive.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            submitTxtProductive.text = "your text will show here"

        //Setting Properties of text field txtPassword
        txtAddGoal.delegate = self

        txtAddGoal.borderStyle = UITextField.BorderStyle.roundedRect
        txtAddGoal.textColor = SKColor.black
            txtAddGoal.placeholder = "Add Goal"
        txtAddGoal.backgroundColor = SKColor.white
        txtAddGoal.autocorrectionType = UITextAutocorrectionType.yes

        txtAddGoal.clearButtonMode = UITextField.ViewMode.whileEditing
        txtAddGoal.autocapitalizationType = UITextAutocapitalizationType.allCharacters
            self.view!.addSubview(txtAddGoal)

            submitTxtAddGoal.fontSize = 22
            submitTxtAddGoal.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            submitTxtProductive.text = "your text will show here"

        txtManageWorkLoad.delegate = self

        txtManageWorkLoad.borderStyle = UITextField.BorderStyle.roundedRect
        txtManageWorkLoad.textColor = SKColor.black
        txtManageWorkLoad.placeholder = "Manage Workload Write Yes/No"
        txtManageWorkLoad.backgroundColor = SKColor.white
        txtManageWorkLoad.autocorrectionType = UITextAutocorrectionType.yes

        txtManageWorkLoad.clearButtonMode = UITextField.ViewMode.whileEditing
        txtManageWorkLoad.autocapitalizationType = UITextAutocapitalizationType.allCharacters
            self.view!.addSubview(txtManageWorkLoad)

            submitTxtManageWorkLoad.fontSize = 22
        submitTxtManageWorkLoad.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            submitTxtProductive.text = "your text will show here"
        //Adding Text Boxes As child nodes
            addChild(submitTxtProductive)
            addChild(submitTxtAddGoal)
            addChild(submitTxtManageWorkLoad)
//
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let touchLocation = t.location(in: self)
            
            if atPoint(touchLocation).name == "lblSignUp"{
                 txtProductive.removeFromSuperview()
                txtManageWorkLoad.removeFromSuperview()
                txtAddGoal.removeFromSuperview()
              
            
                let gameScene = SKScene(fileNamed: "ProductivityScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }
            
            //Navigation to TimerScene when user clicks Login
            if atPoint(touchLocation).name == "lblLogin"{
             
                txtProductive.removeFromSuperview()
               txtManageWorkLoad.removeFromSuperview()
               txtAddGoal.removeFromSuperview()
                let gameScene = SKScene(fileNamed: "LoginScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }
        }
    }
}
