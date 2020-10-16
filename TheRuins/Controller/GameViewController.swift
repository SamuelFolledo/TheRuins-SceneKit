//
//  GameViewController.swift
//  TheRuins
//
//  Created by Samuel Folledo on 8/22/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SceneKit

enum GameState {
    case loading, playing
}

class GameViewController: UIViewController {
    
    lazy var gameView: GameView = { return view as! GameView }()
    var mainScene: SCNScene!
    var gameState: GameState = .loading
    //nodes
    private var player: Player!
    //movement
    private var controllerStoredDirection = float2(0.0) //used for parallel programming
    private var padTouch: UITouch? //will hold user's touch whenever use touch inside the pad
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupPlayer()
        
        gameState = .playing
    }
    
    override var shouldAutorotate: Bool { return true }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    //MARK: Scene
    
    private func setupScene() {
//        gameView.allowsCameraControl = true
        gameView.antialiasingMode = .multisampling4X
        gameView.delegate = self
//        mainScene.physicsWorld.contactDelegate = self
        mainScene = SCNScene(named: "art.scnassets/Scenes/Stage1.scn") //load Stage1.scn as our mainScene
        gameView.scene = mainScene
        gameView.isPlaying = true //start game loop and animation
    }
    
    //MARK: Walls
    
    //MARK: Camera
    
    //MARK: Player
    
    private func setupPlayer() {
        player = Player()
        player.scale = SCNVector3Make(0.0026, 0.0026, 0.0026)
        player.position = SCNVector3Make(0, 0, 0)
        player.rotation = SCNVector4Make(0, 1, 0, Float.pi)
        mainScene.rootNode.addChildNode(player)
    }
    
    //MARK: Touches + Movements
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if gameView.virtualDpadBounds().contains(touch.location(in: gameView)) { //detect if user touch the dpad
                if padTouch == nil {
                    padTouch = touch
                    controllerStoredDirection = float2(0.0)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = padTouch {
            let displacement = float2(touch.location(in: view)) - float2(touch.previousLocation(in: view))
            let vMix = mix(controllerStoredDirection, displacement, t: 0.1)
            let vClamp = clamp(vMix, min: -1.0, max: 1.0)
            controllerStoredDirection = vClamp
        }
//        else if let touch = cameraTouch {
//            let displacement = float2(touch.location(in: view)) - float2(touch.previousLocation(in: view))
//            panCamera(displacement)
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        padTouch = nil
        controllerStoredDirection = float2(0.0)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        padTouch = nil
        controllerStoredDirection = float2(0.0)
    }
    
    private func characterDirection() -> float3 {
        var direction = float3(controllerStoredDirection.x, 0.0, controllerStoredDirection.y) //used 3 to make calculations faster
        if let pov = gameView.pointOfView { //pointOfView is what user sees in the camera
            let p1 = pov.presentation.convertPosition(SCNVector3(direction), to: nil) //convert the direction
            let p0 = pov.presentation.convertPosition(SCNVector3Zero, to: nil)
            direction = float3(Float(p1.x-p0.x), 0.0, Float(p1.z-p0.z))
            if direction.x != 0.0 || direction.z != 0.0 { //normalize if not 0
                direction = normalize(direction)
            }
        }
        return direction
    }
    
    //MARK: Game Loop Functions
    
    //MARK: Enemies
}

//MARK: Extensions

//MARK: SCNSceneRendererDelegate
extension GameViewController: SCNSceneRendererDelegate {
    
//    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
//        if gameState != .playing { return }
//        for (node,position) in replacementPositions {
//            node.position = position
//        }
//    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if gameState != .playing { return }
        //reset
//        replacementPositions.removeAll()
//        maxPenetrationDistance = 0.0
        let scene = gameView.scene!
        let direction = characterDirection()
//        print("Direction = \(direction)")
        player!.walkInDirection(direction, time: time, scene: scene)
//        updateFollowersPositions()
//        //golems
//        mainScene.rootNode.enumerateChildNodes { (node, _) in
//            if let name = node.name {
//                switch name {
//                case "Golem":
//                    (node as! Golem).update(with: time, and: scene)
//                default:
//                    break
//                }
//            }
//        }
    }
}
