//
//  BoardGameScene.swift
//  Trapper Extreme
//  Adapted from http://www.raywenderlich.com/75270/make-game-like-candy-crush-with-swift-tutorial-part-1
//  Created by Denis Thamrin on 19/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import SpriteKit

class BoardGameScene: SKScene {
    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
    let boardGameLayer = SKNode()
    let boardPieceLayer = SKNode()
    
    
    override func didMoveToView(view: SKView) {
        setBackground()
        
    }
    
    //Set background Image
    private func setBackground(){
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let background = SKSpriteNode(imageNamed: "Background")
        addChild(background)
    }
    
    //Set layers on the tile
    // Change 10 to number of rows
    private func setLayer(){
        addChild(boardGameLayer)
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(10) / 2,
            y: -TileHeight * CGFloat(10) / 2)
        boardPieceLayer.position = layerPosition
        boardGameLayer.addChild(boardPieceLayer)
    }

}
