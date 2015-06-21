//
//  BoardGameScene.swift
//  Trapper Extreme
//  Adapted from http://www.raywenderlich.com/75270/make-game-like-candy-crush-with-swift-tutorial-part-1
//  Created by Denis Thamrin on 19/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
// Delegate ? or make it generic ?
//

import SpriteKit

class BoardGameScene: SKScene {
    var board:Board<PieceType>!
    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
    let boardGameLayer = SKNode()
    let boardPieceLayer = SKNode()
    let tilesLayer = SKNode()
    
    
    override func didMoveToView(view: SKView) {
        setBackground()
        setLayer()
        addTiles()
        //addPiece()
    }
    
    private func addPiece(){
        for x in 0..<board.boardDimension{
            for y in 0..<board.boardDimension{
                let sprite = SKSpriteNode(imageNamed: board.board[x][y]!.spriteName)
                sprite.position = positionForView(x,y: y)
                boardPieceLayer.addChild(sprite)
            }
        }
    }
    
    private func addTiles(){
        for x in 0..<board.boardDimension{
            for y in 0..<board.boardDimension{
                let tile = SKSpriteNode(imageNamed: "Tile")
                tile.position = positionForView(x,y: y)
                tilesLayer.addChild(tile)
            }
        }
    }
    


    //Set background Image
    private func setBackground(){
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let background = SKSpriteNode(imageNamed: "Background")
        addChild(background)
    }
    
    //Set layers on the tile
    // Change 10 to number of rows
    // should boardPieceLayer added to tiles layer
    private func setLayer(){
        addChild(boardGameLayer)
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(board.boardDimension) / 2,
            y: -TileHeight * CGFloat(board.boardDimension) / 2)
        tilesLayer.position = layerPosition
        boardGameLayer.addChild(tilesLayer)
        
        // add to child of tilesLayer ???
        boardPieceLayer.position = layerPosition
        boardGameLayer.addChild(boardPieceLayer)
        
    }
    
    //Helper function covert grid position to view coordinate
    private func positionForView(x: Int, y: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(x)*TileWidth + TileWidth/2,
            y: CGFloat(y)*TileHeight + TileHeight/2)
    }

}
