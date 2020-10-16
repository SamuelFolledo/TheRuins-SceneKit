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
}

extension Player: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
