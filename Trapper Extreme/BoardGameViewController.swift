//
//  ViewController.swift
//  Trapper Extreme
//
//  Created by Denis Thamrin on 17/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//  First prototype where model is inside controller
//

import UIKit
import SpriteKit

protocol HumanInputDelegate{
    func humanInput(sender:BoardGameViewController,x:Int,y:Int)
}

class BoardGameViewController: UIViewController,boardGameSceneDataSource {
    var board:Board!
    var scene:BoardGameScene!

    let gameSize = 6
 
    
    //TemporaryGameCode
    var p1:HumanPlayer!
    var p2:HumanPlayer!
    var currentSide:Bool!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    }
    
    func setUpScene(){
        // Configure the view
        let skView = view! as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        self.scene = BoardGameScene(size: skView.bounds.size)
        self.scene.dataSource = self
        
        //self.scene.board = self.board
        self.scene.scaleMode = .AspectFill
       
        // Presentthe scene
        skView.presentScene(self.scene)
    }
    
    func boardSizeForScene(sender: BoardGameScene) -> Int! {
        return self.board.boardDimension
    }
    
    func boardForScene(sender: BoardGameScene) -> [[BoardPiece?]]! {
        return self.board.board!
    }
    
    func scoreForScene(sender: BoardGameScene) -> (Int, Int)! {
        return (self.board.blackScore,self.board.whiteScore)
    }
    
    func settingsButtonPressed(sender:BoardGameScene){
        NSLog("Setting button Pressed,currently implementing refresh game")
        setUpBoard()
        setUpScene()
    }

    
    func pieceTouched(sender: BoardGameScene, x: Int!, y: Int!)-> Bool {
        let move:Move!
        if currentSide!{
           p1.humanInput(self, x: x, y: y)
            move = p1.playMove()
        } else {
            p2.humanInput(self,x: x,y:y)
            move = p2.playMove()
        }
        let validMove = board.addPiece(move.player, x: move.x, y: move.y)
        if (validMove){
            currentSide = !currentSide
        }
        //TODO
        return validMove
    }
    
    func setUpBoard(){
        self.board = Board(boardDimension: gameSize,initialValue: PieceType.EmptyCell)
        
    }
    
    func setUpGame(){
        self.p1 = HumanPlayer(player: PieceType.Black)
        self.p2 = HumanPlayer(player: PieceType.White)
        currentSide = true
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBoard()
        setUpScene()
        setUpGame()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

