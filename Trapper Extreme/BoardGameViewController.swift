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
    var board:Board<PieceType>!
    var scene:BoardGameScene!
    
 
    
    
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
    func spriteForScene(sender: BoardGameScene,x:Int!,y:Int!) -> String! {
        return self.board.board[x][y]?.spriteName
    }
    
    func pieceTouched(sender: BoardGameScene, x: Int!, y: Int!)-> Bool {
        return board.addPiece(PieceType.Black, x: x, y: y)
        
        //TODO
    }
    
    func setUpBoard(){
        self.board = Board<PieceType>(boardDimension: 3,initialValue: PieceType.EmptyCell)
        
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

