//
//  GameOverViewController.swift
//  Trapper Extreme
//
//  Created by Denis Thamrin on 7/07/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//
//[self.navigationController popToRootViewControllerAnimated:YES];

import UIKit
import SpriteKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var winLabel: UILabel!
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func playAgain(sender: UIButton) {
    }
}