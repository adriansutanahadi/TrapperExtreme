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

class BoardGameViewController: UIViewController,boardGameSceneDataSource {
    var board:Board!
    var scene:BoardGameScene!
    
    let gameSize = 3
 
    
    
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
    
    func pieceTouched(sender: BoardGameScene, x: Int!, y: Int!)-> Bool {
        
        let validMove = board.addPiece(PieceType.Black, x: x, y: y)
        
        //TODO
        return validMove
    }
    
    func setUpBoard(){
        self.board = Board(boardDimension: gameSize,initialValue: PieceType.EmptyCell)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBoard()
        setUpScene()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

