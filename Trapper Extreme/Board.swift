//
//  Board.swift
//  Trapper Extreme
//  Board encapsulates the game state of the board, implemented using 2d array of Generics
//  Created by Denis Thamrin on 18/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

class Board<T>{
    private var board: [[T?]]! = [[T?]]()
    
    let boardDimension: Int
    
    init(boardDimension:Int){
        self.boardDimension =  boardDimension
        for row in (0...boardDimension) {
            for column in (0...boardDimension) {
                self.board[row][column] = nil
            }
        }
        
    }

}