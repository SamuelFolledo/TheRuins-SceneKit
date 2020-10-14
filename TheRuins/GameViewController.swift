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
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
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
        gameView.allowsCameraControl = true
        gameView.antialiasingMode = .multisampling4X
        mainScene = SCNScene(named: "art.scnassets/Scenes/Stage1.scn") //load Stage1.scn as our mainScene
        gameView.scene = mainScene
        gameView.isPlaying = true //start game loop and animation
    }
    
    //MARK: Walls
    
    //MARK: Camera
    
    //MARK: Player
    
    //MARK: Touches + Movements
    
    //MARK: Game Loop Functions
    
    //MARK: Enemies
}

//MARK: Extensions
