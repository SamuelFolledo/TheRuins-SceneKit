//
//  GameViewController.swift
//  TheRuins
//
//  Created by Samuel Folledo on 8/22/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    //MARK: Walls
    
    //MARK: Camera
    
    //MARK: Player
    
    //MARK: Touches + Movements
    
    //MARK: Game Loop Functions
    
    //MARK: Enemies
}

//MARK: Extensions
