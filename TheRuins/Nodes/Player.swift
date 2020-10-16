//
//  Player.swift
//  TheRuins
//
//  Created by Samuel Folledo on 10/15/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import SceneKit

enum PlayerAnimationType {
    case walk, attack1, dead
}

class Player: SCNNode {
    //nodes
    private var daeHolderNode = SCNNode()
    private var characterNode: SCNNode!
    
    //animations
    private var walkAnimation = CAAnimation()
    private var attack1Animation = CAAnimation()
    private var deadAnimation = CAAnimation()
    
    //movement
    private var previousUpdateTime = TimeInterval(0.0)
    private var isWalking: Bool = false {
        didSet {
            if isWalking != oldValue {
                if isWalking {
                    characterNode.addAnimation(walkAnimation, forKey: "walk")
                } else {
                    characterNode.removeAnimation(forKey: "walk", blendOutDuration: 0.2)
                }
            }
        }
    }
    private var directionAngle: Float = 0.0 {
        didSet {
            if directionAngle != oldValue { //if new value is different from the old value
                runAction(SCNAction.rotateTo(x: 0.0, y: CGFloat(directionAngle), z: 0.0, duration: 0.1, usesShortestUnitArc: true))
            }
        }
    }
    
    //MARK: Initialization
    override init() {
        super.init()
        setupModel()
        loadAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Scene
    func setupModel() {
        //load dae childs
        let playerUrl = Bundle.main.url(forResource: "art.scnassets/Scenes/Hero/idle", withExtension: "dae")
        let playerScene = try! SCNScene(url: playerUrl!, options: nil) //create a SceneKitScene from the dae
        for child in playerScene.rootNode.childNodes { //add all nodes to daeHolderNode
            daeHolderNode.addChildNode(child)
        }
        addChildNode(daeHolderNode) //add daeHolderNode to self
        characterNode = daeHolderNode.childNode(withName: "Bip01", recursively: true)! //Bip01 is the bone of the dae file
    }
    
    //MARK: Animations
    func loadAnimations() {
        loadAnimation(animationType: .walk, inSceneNamed: "art.scnassets/Scenes/Hero/walk", withIdentifier: "WalkID")
        loadAnimation(animationType: .attack1, inSceneNamed: "art.scnassets/Scenes/Hero/attack", withIdentifier: "attackID")
        loadAnimation(animationType: .dead, inSceneNamed: "art.scnassets/Scenes/Hero/die", withIdentifier: "DeathID")
    }
    
    private func loadAnimation(animationType: PlayerAnimationType, inSceneNamed scene: String, withIdentifier identifier: String) {
        let sceneUrl = Bundle.main.url(forResource: scene, withExtension: "dae")!
        let sceneSource = SCNSceneSource(url: sceneUrl, options: nil)!
        let animationObject: CAAnimation = sceneSource.entryWithIdentifier(identifier, withClass: CAAnimation.self)!
        animationObject.delegate = self
        animationObject.fadeInDuration = 0.2
        animationObject.fadeOutDuration = 0.2
        animationObject.usesSceneTimeBase = false
        animationObject.repeatCount = 0 //play animation once
        
        switch animationType {
        case .walk:
            animationObject.repeatCount = Float.greatestFiniteMagnitude
            walkAnimation = animationObject
        case .attack1:
            animationObject.setValue("attack1", forKey: "animationId")
            attack1Animation = animationObject
        case .dead:
            animationObject.isRemovedOnCompletion = false
            deadAnimation = animationObject
        }
    }
    
    //MARK:- movement
    func walkInDirection(_ direction: float3, time: TimeInterval, scene: SCNScene) {
//        if isDead || isAttacking { return }
        if previousUpdateTime == 0.0 { previousUpdateTime = time } //update previousUpdateTime with time parameter
        let deltaTime = Float(min(time - previousUpdateTime, 1.0 / 60.0)) //because we want to achieve 60 FPS in our game
        let characterSpeed = deltaTime * 1.3 //get character speed
        previousUpdateTime = time //update time
//        let initialPosition = position
        //move
        if direction.x != 0.0 && direction.z != 0.0 { //check there is change on directions
            //move character
            let pos = float3(position)
            position = SCNVector3(pos + direction * characterSpeed)
            //update angle
            directionAngle = SCNFloat(atan2f(direction.x, direction.z))
            isWalking = true
        } else {
            isWalking = false
        }
        //update altidute
//        var pos = position
//        var endpoint0 = pos
//        var endpoint1 = pos
//        endpoint0.y -= 0.1
//        endpoint1.y += 0.08
//
//        let results = scene.physicsWorld.rayTestWithSegment(from: endpoint1, to: endpoint0, options: [.collisionBitMask: BitmaskWall, .searchMode: SCNPhysicsWorld.TestSearchMode.closest])
//
//        if let result = results.first {
//
//            let groundAltidute = result.worldCoordinates.y
//            pos.y = groundAltidute
//
//            position = pos
//
//        } else {
//
//            position = initialPosition
//        }
    }
}

extension Player: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
