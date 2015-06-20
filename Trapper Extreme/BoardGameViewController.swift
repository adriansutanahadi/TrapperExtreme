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

class BoardGameViewController: UIViewController {
    var board = Board<PieceType>(boardDimension: 3,initialValue: nil)
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
        let skView = view! as SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        self.scene = BoardGameScene(size: skView.bounds.size)
        self.scene.scaleMode = .AspectFill
        
        // Presentthe scene
        skView.presentScene(self.scene)
    }
    
    func setUpBoard(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScene()
        setUpBoard()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

