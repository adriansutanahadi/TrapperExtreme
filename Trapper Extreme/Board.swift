//
//  Board.swift
//  Trapper Extreme
//  Board encapsulates the game state of the board, implemented using 2d array of Generics
//  Created by Denis Thamrin on 18/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

class Board{
    //Private setter
    private(set) var board: [[BoardPiece?]]!
    
    let boardDimension: Int
    
    init(boardDimension:Int,initialValue:PieceType!){
        self.boardDimension =  boardDimension

        self.board = Array(count:boardDimension, repeatedValue:Array(count:boardDimension, repeatedValue: nil))
        for x in 0...boardDimension-1 {
            for y in 0...boardDimension-1 {
                let initialPiece = BoardPiece(pieceType: initialValue)
                self.board[x][y] = initialPiece
            }
        }
    }
    
    // Index starts from 0,0 . x axis left to right,y axis up to down.
    // Need to add more constraint, such as piece must beeiter Black or White ???
    // If legal return true,else false
    func addPiece(piece:PieceType,x:Int, y:Int) -> Bool{
        if let isFree = self.board[x][y]{
            self.board[x][y]?.pieceType = piece
            return true
        } else {
            return false
        }
    }

}