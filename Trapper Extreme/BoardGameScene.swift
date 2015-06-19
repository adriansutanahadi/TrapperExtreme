//
//  BoardGameScene.swift
//  Trapper Extreme
//  Adapted from http://www.raywenderlich.com/75270/make-game-like-candy-crush-with-swift-tutorial-part-1
//  Created by Denis Thamrin on 19/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import SpriteKit

class BoardGameScene: SKScene {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "Background")
        addChild(background)
    }


}
