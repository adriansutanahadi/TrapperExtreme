//
//  ViewController.swift
//  Trapper Extreme
//
//  Created by Denis Thamrin on 17/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//  First prototype where model is inside controller
//

import UIKit

class ViewController: UIViewController {
    var board: [[String?]]! = [[String?]]()
    
    
    func setUpBoard(){
        for row in 0...3 {
            for column in 0...3 {
                self.board[row][column] = nil
            }
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBoard()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

