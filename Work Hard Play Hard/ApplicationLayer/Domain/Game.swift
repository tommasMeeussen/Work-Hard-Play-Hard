//
//  Game.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-04-13.
//  Copyright © 2021 tm. All rights reserved.
//

import Foundation
import SpriteKit

class Game: NSObject{
    
    var score: Int?
    var userName: String?
    var gameTime: Int?
    var died: Bool?
    var gameStarted: Bool = false
    var highScore = UserDefaults.standard.integer(forKey:"HighScore") ?? 0

    
    
    func startGame(userName: String?){
        print("gameClassstartGAme")

        self.score = 0
        self.userName = userName
        self.gameTime = 60
        self.died = false
        self.gameStarted = true
    }
    
    func IncrementScore(){
        print("incScoreGameClass")

        self.score! += 1
    }
    
    func endGame(){
        self.died = true
        //self.gameStarted = false
        checkHighScore()
        print(highScore)
        
    }
    
    func checkHighScore(){
        if self.score! > highScore{
            UserDefaults.standard.set(self.score!, forKey: "HighScore")
        }
        print(highScore)
    }
}

