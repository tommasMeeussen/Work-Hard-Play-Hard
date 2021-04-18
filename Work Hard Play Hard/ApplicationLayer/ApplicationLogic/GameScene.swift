//
//  GameScene.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-03-22.
//  Copyright © 2021 tm. All rights reserved.
//
// First time making a game in swift so followed this tutorial as reference for game physics and logic : http://sweettutos.com/2017/03/09/build-your-own-flappy-bird-game-with-swift-3-and-spritekit/
//Modifications were made to support architectural pattern and Play Game use case 
import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Bird : UInt32 = 0b1
    static let Ground : UInt32 = 0b10 // 2
    static let Wall : UInt32 = 0b100 // 4
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var Ground = SKSpriteNode()
    var Bird = SKSpriteNode()
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
        //Restarts Game after restart button is clicked
        self.removeAllChildren()
        self.removeAllActions()
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
        scoreLbl.position = CGPoint(x: self.frame.minX+50, y: self.frame.maxY-80)
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 60
        self.addChild(scoreLbl)
        
        hsLbl.position = CGPoint(x: self.frame.maxX-100, y: self.frame.maxY-80)
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
        Ground.physicsBody?.collisionBitMask = PhysicsCategory.Bird
        Ground.physicsBody?.contactTestBitMask  = PhysicsCategory.Bird
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.isDynamic = false
        Ground.zPosition = 3
        self.addChild(Ground)
        
        
        //Creating Bird character sprite for game and setting up bird physics categories
        Bird = SKSpriteNode(imageNamed: "whphBird")
        Bird.size = CGSize(width: 60, height: 70)
        Bird.position = CGPoint(x: self.frame.minX + Bird.frame.width*2, y: 0)
        Bird.physicsBody = SKPhysicsBody(circleOfRadius: Bird.frame.height / 2)
        Bird.physicsBody?.categoryBitMask = PhysicsCategory.Bird
        Bird.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
        Bird.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
        Bird.physicsBody?.affectedByGravity = false
        Bird.physicsBody?.isDynamic = true
        Bird.zPosition = 2
        self.addChild(Bird)
        
    }
    
    override func didMove(to view: SKView) {
        //Starting game by setting up physics and creating scene
        self.physicsWorld.contactDelegate = self
        createScene()
        
    }
    
    @objc func endGame(){
        //Stops game after break timer is done and returns to TimerScene
        scoreTimer?.invalidate()
        gameTimer?.invalidate()
        scoreTimer = nil
        gameTimer = nil

        removeAllActions()
        print("game over")
        game.score = 0
        game.died = true
        let homeScreen = SKScene(fileNamed: "TimerScene")
        homeScreen?.scaleMode = .aspectFill
        view?.presentScene(homeScreen!, transition: SKTransition.doorsCloseVertical(withDuration: TimeInterval(2)))
    }
    
    @objc func IncrementScore(){
        //Increments score with timer
        game.IncrementScore()
        self.scoreLbl.text = "\(game.score ?? 0)"
        
    }
    
    func createBTN(){
        //Creates restart game button
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
        //Checks Collision between objects
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
      
        //Checks if bird has hit wall
       if firstBody.categoryBitMask == PhysicsCategory.Bird && secondBody.categoryBitMask == PhysicsCategory.Wall || firstBody.categoryBitMask == PhysicsCategory.Wall && secondBody.categoryBitMask == PhysicsCategory.Bird{
            
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                
                node.speed = 0
                self.removeAllActions()
                
            }))
            if game.died == false{
                //ends game and creates restart button
                game.endGame()
                game.died = true
                createBTN()
            }
        }
        //Checks if bird has hit ground
        else if firstBody.categoryBitMask == PhysicsCategory.Bird && secondBody.categoryBitMask == PhysicsCategory.Ground || firstBody.categoryBitMask == PhysicsCategory.Ground && secondBody.categoryBitMask == PhysicsCategory.Bird{
            
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                
                node.speed = 0
                self.removeAllActions()
                
            }))
            if game.died == false{
                //ends game and creates restart button
                game.endGame()
                game.died = true
                createBTN()
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
     for t in touches {
        let touchLocation = t.location(in: self)
        
    }
        if game.gameStarted == false{
            
            
            game.startGame(userName: "User 1")
            
            Bird.physicsBody?.affectedByGravity = true
            
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
            
            Bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            Bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
        }
        else{
            
            if game.died == true{
                
                
            }
            else{
                Bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                Bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
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
        //Creates moving wall obstacles
        print("createWalls")
        var randomPosition = random(min: CGFloat(-200), max: CGFloat(200))
        
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
        topWall.physicsBody?.collisionBitMask = PhysicsCategory.Bird
        topWall.physicsBody?.contactTestBitMask = PhysicsCategory.Bird
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        btmWall.physicsBody?.collisionBitMask = PhysicsCategory.Bird
        btmWall.physicsBody?.contactTestBitMask = PhysicsCategory.Bird
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false

        topWall.zRotation = CGFloat(M_PI)
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1
        wallPair.position.y = wallPair.position.y +  randomPosition
        wallPair.run(moveAndRemove)
        
        self.addChild(wallPair)
        
    }
    
    func random() -> CGFloat{
    //generates random number for wall spacing
           return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
       }
       
       func random(min:CGFloat, max: CGFloat) -> CGFloat{
        print("random")

           return random() * (max-min) + min
       }
    
            
        }
        
        
        
        

