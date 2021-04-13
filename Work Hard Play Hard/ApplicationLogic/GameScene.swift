//
//  GameScene.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-03-22.
//  Copyright © 2021 tm. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Ghost : UInt32 = 0b1
    static let Ground : UInt32 = 0b10 // 2
    static let Score : UInt32 = 0b11 // 3
    static let Wall : UInt32 = 0b100 // 4
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var Ground = SKSpriteNode()
    var Ghost = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var removeAnd = SKAction()
    var gameStarted = Bool()
    let scoreLbl = SKLabelNode()
    let hsLbl = SKLabelNode()
    
    var restartBTN = SKSpriteNode()

    var died = Bool()
    private var score : Int = 0
    var gameTimer: Timer?
    var scoreTimer: Timer?
    
    let game = Game()
    
   
    
    
    
    func restartScene(){
        
        print("restarting")
        self.removeAllChildren()
        self.removeAllActions()
        //game.startGame(userName: "User 1")
        game.gameStarted = false
        createScene()
        
    }
    
    func createScene(){
        
        //Creating game and score timers
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(IncrementScore), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(endGame), userInfo: nil, repeats: true)
        
        //Creating Scoreboard
        game.score = 0
        scoreLbl.text = "\(game.score ?? 0)"
        hsLbl.text = "\(game.highScore)"
        scoreLbl.position = CGPoint(x: self.frame.minX+50, y: self.frame.maxY-60)
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 60
        self.addChild(scoreLbl)
        
        hsLbl.position = CGPoint(x: self.frame.maxX-100, y: self.frame.maxY-60)
        hsLbl.zPosition = 5
        hsLbl.fontSize = 60
        self.addChild(hsLbl)
        
        //Creating ground sprite for game and setting up bird physics categories

        Ground = SKSpriteNode(imageNamed: "Ground")
        Ground.setScale(0.5)
        Ground.position = CGPoint(x: self.frame.minX , y: self.frame.minY)
        Ground.size = CGSize(width: self.frame.width+500, height: 100)
        Ground.physicsBody = SKPhysicsBody(rectangleOf: Ground.size)
        Ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        Ground.physicsBody?.collisionBitMask = PhysicsCategory.Ghost
        Ground.physicsBody?.contactTestBitMask  = PhysicsCategory.Ghost
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.isDynamic = false
        Ground.zPosition = 3
        self.addChild(Ground)
        
        
        //Creating Bird character sprite for game and setting up bird physics categories
        Ghost = SKSpriteNode(imageNamed: "whphBird")
        Ghost.size = CGSize(width: 60, height: 70)
        Ghost.position = CGPoint(x: self.frame.minX + Ghost.frame.width*2, y: 0)
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask = PhysicsCategory.Ghost
        Ghost.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
        Ghost.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall | PhysicsCategory.Score
        Ghost.physicsBody?.affectedByGravity = false
        Ghost.physicsBody?.isDynamic = true
        Ghost.zPosition = 2
        self.addChild(Ghost)
        
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
//        game.score = 0
//        scoreLbl.text = "\(game.score ?? 0)"
//        hsLbl.text = "\(game.highScore)"
        createScene()
        
    }
    
    @objc func endGame(){
        scoreTimer?.invalidate()
        gameTimer?.invalidate()
        scoreTimer = nil
        gameTimer = nil

        removeAllActions()
        print("game over")
        game.score = 0
        game.died = true
        let homeScreen = SKScene(fileNamed: "TimerScene")
        homeScreen?.scaleMode = .aspectFit
        view?.presentScene(homeScreen!, transition: SKTransition.doorsCloseVertical(withDuration: TimeInterval(2)))
    }
    
    @objc func IncrementScore(){
        
        game.IncrementScore()
        //game.score! += 1
        self.scoreLbl.text = "\(game.score ?? 0)"
        
    }
    
    func createBTN(){
        scoreTimer?.invalidate()
        restartBTN = SKSpriteNode(imageNamed: "RestartBtn")
        restartBTN.size = CGSize(width: 200, height: 100)
        restartBTN.position = CGPoint(x: 0, y: 0)
        restartBTN.zPosition = 6
        restartBTN.setScale(0)
        self.addChild(restartBTN)
        restartBTN.run(SKAction.scale(to: 1.0, duration: 0.3))
        hsLbl.text = "\(game.highScore)"
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
      
       if firstBody.categoryBitMask == PhysicsCategory.Ghost && secondBody.categoryBitMask == PhysicsCategory.Wall || firstBody.categoryBitMask == PhysicsCategory.Wall && secondBody.categoryBitMask == PhysicsCategory.Ghost{
            
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                
                node.speed = 0
                self.removeAllActions()
                
            }))
            if game.died == false{
                game.endGame()
                game.died = true
                createBTN()
            }
        }
        else if firstBody.categoryBitMask == PhysicsCategory.Ghost && secondBody.categoryBitMask == PhysicsCategory.Ground || firstBody.categoryBitMask == PhysicsCategory.Ground && secondBody.categoryBitMask == PhysicsCategory.Ghost{
            
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                
                node.speed = 0
                self.removeAllActions()
                
            }))
            if game.died == false{
                game.endGame()
                game.died = true
                createBTN()
            }
        }

        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

     for t in touches {
        let touchLocation = t.location(in: self)
        
    }
        if game.gameStarted == false{
            
            
            game.startGame(userName: "User 1")
            
            Ghost.physicsBody?.affectedByGravity = true
            
            let spawn = SKAction.run({
                () in
                
                self.createWalls()
                
            })
            
            let delay = SKAction.wait(forDuration: 1.5)
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
            self.run(spawnDelayForever)
            
            
            let distance = CGFloat(self.frame.width + wallPair.frame.width)
            let movePipes = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
            let removePipes = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePipes, removePipes])
            
            Ghost.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            Ghost.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
        }
        else{
            
            if game.died == true{
                
                
            }
            else{
                Ghost.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                Ghost.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
            }
            
        }
        
        
        
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if game.died == true{
                if restartBTN.contains(location){
                    print("button created")
                    restartScene()
                }
            }
        }
        
        
        
        
        
        
    }
    
    func createWalls(){
        
        var randomPosition = random(min: CGFloat(-200), max: CGFloat(200))

        
//        let scoreNode = SKSpriteNode(imageNamed: "Coin")
//
//        scoreNode.size = CGSize(width: 200, height: 200)
//        scoreNode.position = CGPoint(x: self.frame.width + 25, y: (self.frame.height / 2))
//        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
//        scoreNode.physicsBody?.affectedByGravity = false
//        scoreNode.physicsBody?.isDynamic = false
//        scoreNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
//        scoreNode.physicsBody?.collisionBitMask = 0
//        scoreNode.physicsBody?.contactTestBitMask = PhysicsCategory.Ghost
//        scoreNode.color = SKColor.blue
//
        
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "whphObstacle")
        let btmWall = SKSpriteNode(imageNamed: "whphObstacle")
        
        topWall.position = CGPoint(x: self.frame.maxX + 25, y: self.frame.maxY+120)
        btmWall.position = CGPoint(x: self.frame.maxX + 25, y: self.frame.minY-120)
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        topWall.physicsBody?.collisionBitMask = PhysicsCategory.Ghost
        topWall.physicsBody?.contactTestBitMask = PhysicsCategory.Ghost
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        btmWall.physicsBody?.collisionBitMask = PhysicsCategory.Ghost
        btmWall.physicsBody?.contactTestBitMask = PhysicsCategory.Ghost
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false

        topWall.zRotation = CGFloat(M_PI)
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1
        
        wallPair.position.y = wallPair.position.y +  randomPosition
        //scoreNode.position.y = ((topWall.position.y+randomPosition) + (wallPair.btmWall.position.y+randomPosition))/2
        //wallPair.addChild(scoreNode)
        
        wallPair.run(moveAndRemove)
        
        self.addChild(wallPair)
        
    }
    
    func random() -> CGFloat{
           return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
       }
       
       func random(min:CGFloat, max: CGFloat) -> CGFloat{
           return random() * (max-min) + min
       }
    
    
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        if game.gameStarted == true{
            if game.died == false{
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    
                    var bg = node as! SKSpriteNode
                    
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
                        
                    }
                    
                }))
                
            }
            
            
        }
        
        
        
        
    }
}
