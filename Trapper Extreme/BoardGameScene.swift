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

    
    let tileWidth: CGFloat = 40.0
    let tileHeight: CGFloat = 40.0
    
    var tileSize:CGSize {
        get {
            return CGSize(width: tileWidth, height: tileHeight)
        }
    }
    
    let boardGameLayer = SKNode()
    let boardPieceLayer = SKNode()
    let tilesLayer = SKNode()
    
    let scoreLabel = SKLabelNode(fontNamed:"Chalkboard")
    let settingButton = SKSpriteNode(imageNamed: "SettingButton")
  
    //Delegations
    weak var dataSource:boardGameSceneDataSource!
    
    

    //Todo setting button pressed ???
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // 1
//        
//        let touch = touches.first as! UITouch
//        let location = touch.locationInNode(self)
//        let node = self.nodeAtPoint(location)
//        NSLog("\(node.name), \(location)")
//        
////                let (pieceTouched, x, y) = convertPoint(location)
////        NSLog("\(x,y))-
////                if pieceTouched {
////                    let validMove = dataSource.pieceTouched(self,x: x,y: y)
////                    if validMove {
////                        updateScore()
////                    }
// //               }
        
// PERFECT CODE
        let touch = touches.first as! UITouch
        //should be boardPieceLayer debug using self now...
        let pieceLocation = touch.locationInNode(boardPieceLayer)
        // 2
        let (pieceTouched, x, y) = convertPoint(pieceLocation)
       
        if pieceTouched {
            let validMove = dataSource.pieceTouched(self,x: x,y: y)
            if validMove {
                updateScore()
            }
        }
        
        //Uses different layer, expect to use self
        else {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
        
         
                if node.name == "SettingButton"{
                    dataSource.settingsButtonPressed(self)
            }
          
        }
      
    }
    
    
    override func didMoveToView(view: SKView) {
        scene!.scaleMode = SKSceneScaleMode.AspectFill
        
        setBackground()
        
        setLayer()
       
        displayTiles()
        displayPiece()
        displaySetting()
        displayScore()
        
    }
    
    private func displaySetting(){
        let boardDimension = dataSource.boardSizeForScene(self)
        
       
        settingButton.name = "SettingButton"

        settingButton.size = tileSize
      
    
        settingButton.position = CGPoint(x:self.size.width/2 - tileWidth, y: self.size.height/2 - tileHeight )

        
        
        
        //THIS CODE CAUSE BUG BUT WHY ?
         //settingButton.userInteractionEnabled = true
        self.addChild(settingButton)
        
    }
    
    
    private func displayScore(){
        /* Setup your scene here */
        let boardDimension = dataSource.boardSizeForScene(self)
        let (p1,p2) = dataSource.scoreForScene(self)
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.text = "\(p1) - \(p2)"
        //scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        scoreLabel.fontSize = 24
        scoreLabel.position = CGPoint(x:0, y:tileWidth * CGFloat(boardDimension)/2)
        //scoreLabel.zRotation = CGFloat(M_PI_2)
        self.addChild(scoreLabel)
    }
    
    private func updateScore(){
        let (p1,p2) = dataSource.scoreForScene(self)
        scoreLabel.text = "\(p2) - \(p1)";
    }
    
    //display initial piece
    private func displayPiece(){
        let boardDimension = dataSource.boardSizeForScene(self)
        let board = dataSource.boardForScene(self)
        for x in 0..<boardDimension{
            for y in 0..<boardDimension{
                board[x][y]!.sprite!.position = positionForView(x,y: y)
                  board[x][y]!.sprite!.name = "Piece \(x,y)"
                board[x][y]!.sprite!.size = tileSize
                boardPieceLayer.addChild(board[x][y]!.sprite!)

            }
        }
    }
    
    private func displayTiles(){
        let boardDimension = dataSource.boardSizeForScene(self)
        for x in 0..<boardDimension{
            for y in 0..<boardDimension{
                let tile = SKSpriteNode(imageNamed: "Tile")
                tile.position = positionForView(x,y: y)
                tile.size = tileSize
          //      NSLog("tiles position \(tile.position)")
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
            x: -tileWidth * CGFloat(boardDimension) / 2,
            y: -tileHeight * CGFloat(boardDimension) / 2)
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
            x: CGFloat(x)*tileWidth + tileWidth/2,
            y: CGFloat(boardDimension-1-y)*tileHeight + tileHeight/2)
    }
    
    func convertPoint(point: CGPoint) -> (success: Bool, x: Int, y: Int) {
        let boardDimension = dataSource.boardSizeForScene(self)
        if point.x >= 0 && point.x < CGFloat(boardDimension)*tileWidth &&
            point.y >= 0 && point.y < CGFloat(boardDimension)*tileHeight {
                return (true, Int(point.x / tileWidth), boardDimension-1 - Int(point.y / tileHeight) )
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
    
    

}
