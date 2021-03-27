//
//  SignUpScene.swift
//  Work Hard Play Hard
//
//  Created by Onell Daniyal on 2021-03-27.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class SignUpScene: SKScene, UITextFieldDelegate{
    
    var lblTitle = SKLabelNode()
    var lblSignUp = SKLabelNode()
    
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
        
        
        //Setting position of UIKit elements
        txtUserName = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 80, width: 320, height: 40))
        
        txtPassword = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))

        // adding subview of the UITextFields
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
        
        //Adding Text Boxes as child nodes
            addChild(submitTxtUserName)
            addChild(submitTxtPassword)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let touchLocation = t.location(in: self)
            
            //Navigation to TimerScene when user creates account
            if atPoint(touchLocation).name == "lblSignUp"{
                txtUserName.removeFromSuperview()
                txtPassword.removeFromSuperview()

                let timerScene = SKScene(fileNamed: "TimerScene")
                timerScene?.scaleMode = .aspectFit
                view?.presentScene(timerScene!)
            }
        }
    }
}
