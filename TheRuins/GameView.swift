//
//  GameView.swift
//  TheRuins
//
//  Created by Samuel Folledo on 8/22/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import SceneKit
import SpriteKit

//will hold the SpriteKit 2D UI

class GameView: SCNView {
    
    lazy var sceneWidth = bounds.size.width
    lazy var sceneHeight = bounds.size.height
    private var skScene: SKScene!
    private let overlayNode = SKNode()
    private var dpadSprite: SKSpriteNode!
    private var attackButtonSprite: SKSpriteNode!
    private var hpBar: SKSpriteNode!
    private let hpBarMaxWidth: CGFloat = 150
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup2DOverlay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout2DOverlay()
    }
    
    deinit {
        
    }
    
    private func setup2DOverlay() {
        skScene = SKScene(size: CGSize(width: sceneWidth, height: sceneHeight))
        skScene.scaleMode = .resizeFill
        skScene.addChild(overlayNode)
        overlayNode.position = CGPoint(x: 0, y: sceneHeight)
        overlaySKScene = skScene
        skScene.isUserInteractionEnabled = true
        setupDpad(with: skScene)
        setupAttackButton(with: skScene)
        setupHpBar(with: skScene)
    }
    
    fileprivate func layout2DOverlay() {
        overlayNode.position = CGPoint(x: 0, y: sceneHeight)
//        attackButtonSprite.position = CGPoint(x: sceneHeight - 110.0, y: 50)
//        hpBar.position = CGPoint(x: 15, y: sceneWidth - 35)
    }
    
    //MARK: Internal Functions
    
    //MARK: D-Pad
    private func setupDpad(with scene: SKScene) {
        dpadSprite = SKSpriteNode(imageNamed: "art.scnassets/Assets/dpad.png")
        dpadSprite.position = CGPoint(x: 10, y: 10)
        dpadSprite.xScale = 1.0
        dpadSprite.yScale = 1.0
        dpadSprite.anchorPoint = CGPoint(x: 0, y: 0)
        dpadSprite.size = CGSize(width: 150, height: 150)
        scene.addChild(dpadSprite)
    }
    
    //returns the boundary of the dpad
    func virtualDpadBounds() -> CGRect {
        var virtualDpadBounds = CGRect(x: 10, y: 10, width: 150, height: 150)
        virtualDpadBounds.origin.y = sceneHeight - virtualDpadBounds.size.height + virtualDpadBounds.origin.y
        return virtualDpadBounds
    }
    
    //MARK: Attack Button
    
    fileprivate func setupAttackButton(with scene: SKScene) {
        attackButtonSprite = SKSpriteNode(imageNamed: "art.scnassets/Assets/attack1.png")
        attackButtonSprite.size = CGSize(width: 60, height: 60)
//        attackButtonSprite.position = CGPoint(x: sceneHeight - 110.0, y: 50)
        attackButtonSprite.position = CGPoint(x: sceneHeight - 120, y: 50)
        attackButtonSprite.xScale = 1.0
        attackButtonSprite.yScale = 1.0
        attackButtonSprite.anchorPoint = CGPoint(x: 0, y: 0)
        attackButtonSprite.name = "attackButton"
        scene.addChild(attackButtonSprite)
    }
    
    func virtualAttackButtonBounds() -> CGRect {
//        var virtualAttackButtonBounds = CGRect(x: sceneWidth - 100, y: 50, width: 60, height: 60)
        var virtualAttackButtonBounds = CGRect(x: sceneWidth - attackButtonSprite.size.width * 2 + 10, y: 50, width: 60, height: 60)
        virtualAttackButtonBounds.origin.y = sceneHeight - virtualAttackButtonBounds.size.height + virtualAttackButtonBounds.origin.y
        return virtualAttackButtonBounds
    }
    
    //MARK: HP Bar
    fileprivate func setupHpBar(with scene: SKScene) {
        hpBar = SKSpriteNode(color: .green, size: CGSize(width: hpBarMaxWidth, height: 20))
//        hpBar.position = CGPoint(x: 15, y: sceneWidth - 35) //answer!
        hpBar.position = CGPoint(x: 15, y: sceneWidth - hpBar.size.height * 4)
//        hpBar.position = CGPoint(x: 15, y: 380)
        hpBar.anchorPoint = CGPoint(x: 0, y: 0)
        hpBar.xScale = 1.0
        hpBar.yScale = 1.0
        scene.addChild(hpBar)
    }
}
