//
//  SettingsViewController.swift
//  Trapper Extreme
//
//  Created by Denis Thamrin on 7/07/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//


//[self.navigationController popToRootViewControllerAnimated:YES];
import UIKit


class SettingsGameViewController: UIViewController {
    
    @IBOutlet weak var boardSizeLabel: UILabel!
    
    
    
    @IBAction func keepGoing(sender: UIButton) {
    }
    
    @IBAction func restartGame(sender: UIButton) {
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func setBoardSize(sender: UIButton) {
        if sender.titleLabel?.text == "+"{
            
        } else {
            
        }
    }
    
}