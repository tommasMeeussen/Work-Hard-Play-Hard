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
    
    var Ground = SKSpriteNode()
    var Ghost = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var removeAnd = SKAction()
    let scoreLbl = SKLabelNode()
    var restartBTN = SKSpriteNode()
    var highScore = UserDefaults.standard.integer(forKey:"HighScore") ?? 0

    
    
    func startGame(userName: String?){
        self.score = 0
        self.userName = userName
        self.gameTime = 60
        self.died = false
        self.gameStarted = true
    }
    
    func IncrementScore(){
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
    
    
    
//    required convenience init?(coder decoder: NSCoder) {
//        guard let make = decoder.decodeObject(forKey: "make") as? String,
//        let model = decoder.decodeObject(forKey: "model") as? String,
//        let year = decoder.decodeObject(forKey: "year") as? String,
//        let colour = decoder.decodeObject(forKey: "colour") as? String,
//        let price = decoder.decodeObject(forKey: "price") as? String,
//        let neworused = decoder.decodeObject(forKey: "neworused") as? String
//            else{
//                return nil
//        }
//        self.init()
//        self.initWithData(make: make, model: model, year: year, colour: colour, price: price, neworused: neworused)
//    }
    
//    func encode(with coder: NSCoder) {
//        coder.encode(self.make, forKey: "make")
//        coder.encode(self.model, forKey: "model")
//        coder.encode(self.year, forKey: "year")
//        coder.encode(self.colour, forKey: "colour")
//        coder.encode(self.price, forKey: "price")
//        coder.encode(self.neworused, forKey: "neworused")
//    }
}

