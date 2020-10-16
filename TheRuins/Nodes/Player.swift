//
//  Player.swift
//  TheRuins
//
//  Created by Samuel Folledo on 10/15/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import SceneKit

class Player: SCNNode {
    
    private var daeHolderNode = SCNNode()
    private var characterNode: SCNNode!
    
    //MARK: Initialization
    override init() {
        super.init()
        setupModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Scene
    func setupModel() {
        //load dae childs
        let playerUrl = Bundle.main.url(forResource: "art.scnassets/Scenes/Hero/idle", withExtension: "dae")
        let playerScene = try! SCNScene(url: playerUrl!, options: nil)
        for child in playerScene.rootNode.childNodes {
            daeHolderNode.addChildNode(child)
        }
        addChildNode(daeHolderNode)
    }
}
