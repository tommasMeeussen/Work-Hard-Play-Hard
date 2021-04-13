//
//  GameElements.swift
//  Work Hard Play Hard
//
//  Created by Tommas Meeussen on 2021-04-12.
//  Copyright © 2021 tm. All rights reserved.
//
import Foundation
import SpriteKit

struct CollisionBitMask {
    static let birdCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    func createBird() -> SKSpriteNode {
            //1
            let bird = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("bird1"))
            bird.size = CGSize(width: 50, height: 50)
            bird.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
            //2
            bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
            bird.physicsBody?.linearDamping = 1.1
            bird.physicsBody?.restitution = 0
            //3
            bird.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
            bird.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
            bird.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory
            //4
            bird.physicsBody?.affectedByGravity = false
            bird.physicsBody?.isDynamic = true
            
            return bird
    }
}
