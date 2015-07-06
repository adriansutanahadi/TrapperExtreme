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
    var scene:BoardGameScene!
    
    let gameSize = 6
    
    // game variables
    var p1: Player!
    var p2: Player!
    var game: BoardGame!
    
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
        return self.game.board.boardDimension
    }
    
    func boardForScene(sender: BoardGameScene) -> [[BoardPiece?]]! {
        return self.game.board.board!
    }
    
    func pieceTouched(sender: BoardGameScene, x: Int!, y: Int!)-> Bool {
        return self.game.acceptMove(self, x: x, y: y)
    }
    
    func setUpGame(){
        self.p1 = HumanPlayer(player: PieceType.White)
        self.p2 = HumanPlayer(player: PieceType.Black)
        self.game = TrapperExtremeGame(p1: self.p1, p2: self.p2, boardSize: self.gameSize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGame()
        setUpScene()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
