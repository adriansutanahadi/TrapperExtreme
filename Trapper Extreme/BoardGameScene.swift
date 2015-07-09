//
//  BoardGameScene.swift
//  Trapper Extreme
//  Adapted from http://www.raywenderlich.com/75270/make-game-like-candy-crush-with-swift-tutorial-part-1
//  Created by Denis Thamrin on 19/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
// Delegate ? or make it generic ?
//

import SpriteKit

protocol boardGameSceneDataSource: class{
    func boardSizeForScene(sender: BoardGameScene) -> Int!
        //Tell me if the touch made any change or not, since if it there is no change no need to update view
    func boardForScene(sender: BoardGameScene) -> [[BoardPiece?]]!
    func pieceTouched(sender: BoardGameScene,x:Int!,y:Int!) -> Bool
    func scoreForScene(sender: BoardGameScene) -> (Int,Int)!
    func settingsButtonPressed(sender:BoardGameScene)
    
}


class BoardGameScene: SKScene {
    //should only get dimension
    //var boardPieces:[SKSpriteNode]! = []

    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
   
    
    
    let boardGameLayer = SKNode()
    let boardPieceLayer = SKNode()
    let tilesLayer = SKNode()
    
    let scoreLabel = SKLabelNode(fontNamed:"Chalkboard")
    //Delegations
    weak var dataSource:boardGameSceneDataSource!
    
    

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // 1
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(boardPieceLayer)
        // 2
        let (success, x, y) = convertPoint(location)
        if success {
            let valid = dataSource.pieceTouched(self,x: x,y: y)
            updateScore()
//            print("\(x),\(y)\n")
//            if valid {
//                updateboardPiece()
//            }
            
            // 3
            //Controller work
            //board.addPiece(PieceType.White,x:x,y:y)

        }

    }
    
//    func updateboardPiece(){
//        for sprite in boardPieces{
//            let (sucess,x,y) = convertPoint(sprite.position)
//            assert(sucess)
//            if sucess {
//                sprite.texture = SKTexture(imageNamed: dataSource.spriteForScene(self, x: x, y: y))
//            }
//        }
//    }
    

    
    override func didMoveToView(view: SKView) {
        setBackground()
        setLayer()
        displayTiles()
        displayPiece()
        displayScore()
        displaySetting()
    }
    
    private func displaySetting(){
        
    }
    
    
    private func displayScore(){
        /* Setup your scene here */
        let boardDimension = dataSource.boardSizeForScene(self)
        let (p1,p2) = dataSource.scoreForScene(self)
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.text = "\(p1) - \(p2)";
        //scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        scoreLabel.fontSize = 24;
        scoreLabel.position = CGPoint(x:0, y:TileHeight * CGFloat(boardDimension)/2);
        self.addChild(scoreLabel)
    }
    
    private func updateScore(){
        let (p1,p2) = dataSource.scoreForScene(self)
        scoreLabel.text = "\(p1) - \(p2)";
    }
    
    //display initial piece
    private func displayPiece(){
        let boardDimension = dataSource.boardSizeForScene(self)
        let board = dataSource.boardForScene(self)
        for x in 0..<boardDimension{
            for y in 0..<boardDimension{
            
                //print(board.board[x][y]!.spriteName)
                board[x][y]!.sprite!.position = positionForView(x,y: y)
                boardPieceLayer.addChild(board[x][y]!.sprite!)
//              boardPieces.append(sprite)
            }
        }
    }
    
    private func displayTiles(){
        let boardDimension = dataSource.boardSizeForScene(self)
        for x in 0..<boardDimension{
            for y in 0..<boardDimension{
                let tile = SKSpriteNode(imageNamed: "Tile")
                tile.position = positionForView(x,y: y)
                tilesLayer.addChild(tile)
            }
        }
    }
    
    
    
    


    //Set background Image
    private func setBackground(){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let background = SKSpriteNode(imageNamed: "Background")
        addChild(background)
    }
    
    //Set layers on the tile
    // Change 10 to number of rows
    // should boardPieceLayer added to tiles layer
    private func setLayer(){
        let boardDimension = dataSource.boardSizeForScene(self)
        addChild(boardGameLayer)
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(boardDimension) / 2,
            y: -TileHeight * CGFloat(boardDimension) / 2)
        tilesLayer.position = layerPosition
        boardGameLayer.addChild(tilesLayer)
        
        // add to child of tilesLayer ???
        boardPieceLayer.position = layerPosition
        boardGameLayer.addChild(boardPieceLayer)
        
    }
    
    //Helper function covert grid position to view coordinate
    private func positionForView(x: Int, y: Int) -> CGPoint {
        let boardDimension = dataSource.boardSizeForScene(self)
        return CGPoint(
            x: CGFloat(x)*TileWidth + TileWidth/2,
            y: CGFloat(boardDimension-1-y)*TileHeight + TileHeight/2)
    }
    
    func convertPoint(point: CGPoint) -> (success: Bool, x: Int, y: Int) {
        let boardDimension = dataSource.boardSizeForScene(self)
        if point.x >= 0 && point.x < CGFloat(boardDimension)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(boardDimension)*TileHeight {
                return (true, Int(point.x / TileWidth), boardDimension-1 - Int(point.y / TileHeight) )
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
    
    

}
