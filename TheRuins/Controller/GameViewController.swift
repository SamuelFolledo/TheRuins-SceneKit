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
    
    var gameView: GameView { return view as! GameView }
    var mainScene: SCNScene!
    var gameState: GameState = .loading
    private var player: Player!
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        gameState = .playing
        setupPlayer()
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
        gameView.allowsCameraControl = true
        gameView.antialiasingMode = .multisampling4X
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
    
    //MARK: Game Loop Functions
    
    //MARK: Enemies
}

//MARK: Extensions
