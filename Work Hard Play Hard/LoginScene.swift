//
//  LoginScene.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-03-24.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class LoginScene: SKScene, UITextFieldDelegate{
    
    var lblTitle = SKLabelNode()
    var lblSignUp = SKLabelNode()
    var lblLogin = SKLabelNode()
    // let submitScore = SKSpriteNode(imageNamed: "button")
    let submitTxtUserName = SKLabelNode(fontNamed: "arial")
    let submitTxtUserNameShadow = SKLabelNode(fontNamed: "arial")
    var txtUserName: UITextField!
    
    let submitTxtPassword = SKLabelNode(fontNamed: "arial")
    let submitTxtPasswordShadow = SKLabelNode(fontNamed: "arial")
    var txtPassword: UITextField!
    
    override func didMove( to view: SKView){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //adding the Sprite Kit nodes to the Scene
        lblTitle = self.childNode(withName: "lblTitle") as! SKLabelNode
        lblSignUp = self.childNode(withName: "lblSignUp") as! SKLabelNode
        lblLogin = self.childNode(withName: "lblLogin") as! SKLabelNode
        
        
        //Setting position of UIKit elements
        txtUserName = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 80, width: 320, height: 40))
        
        txtPassword = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))

        // adding subview of the UITextField's to the GameScene's view
        view.addSubview(txtUserName)
        view.addSubview(txtPassword)
        
        //Setting Properties of text field txtPassword
        txtUserName.delegate = self
        
        txtUserName.borderStyle = UITextField.BorderStyle.roundedRect
        txtUserName.textColor = SKColor.black
            txtUserName.placeholder = "User Name"
        txtUserName.backgroundColor = SKColor.white
        txtUserName.autocorrectionType = UITextAutocorrectionType.yes
           
        txtUserName.clearButtonMode = UITextField.ViewMode.whileEditing
        txtUserName.autocapitalizationType = UITextAutocapitalizationType.allCharacters
            self.view!.addSubview(txtUserName)
        
            submitTxtUserName.fontSize = 22
            submitTxtUserName.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            submitTxtUserName.text = "your text will show here"
        
        //Setting Properties of text field txtPassword
        txtPassword.delegate = self
        
        txtPassword.borderStyle = UITextField.BorderStyle.roundedRect
        txtPassword.textColor = SKColor.black
            txtPassword.placeholder = "Password"
        txtPassword.backgroundColor = SKColor.white
        txtPassword.autocorrectionType = UITextAutocorrectionType.yes
           
        txtPassword.clearButtonMode = UITextField.ViewMode.whileEditing
        txtPassword.autocapitalizationType = UITextAutocapitalizationType.allCharacters
            self.view!.addSubview(txtPassword)
        
            submitTxtPassword.fontSize = 22
            submitTxtPassword.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            submitTxtUserName.text = "your text will show here"
        
        //Adding Text Boxes As child nodes
            addChild(submitTxtUserName)
            addChild(submitTxtPassword)
       
        
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let touchLocation = t.location(in: self)
            
            //Navigation to TimerScene when user clicks Login
            if atPoint(touchLocation).name == "lblLogin"{
                txtUserName.removeFromSuperview()
                txtPassword.removeFromSuperview()

                let gameScene = SKScene(fileNamed: "TimerScene")
                gameScene?.scaleMode = .aspectFit
                view?.presentScene(gameScene!)
            }
        }
    }
    
    //TODO: get text input
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//               // Populates the SKLabelNode
//               submitScoreText.text = textField.text
//
//               // Hides the keyboard
//
//               textField.resignFirstResponder()
//               return true
//    }
}
