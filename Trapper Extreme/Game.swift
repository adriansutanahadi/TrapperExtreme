//
//  Game.swift
//  Trapper Extreme
//
//  Created by Adrian Sutanahadi on 6/07/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

protocol BoardGame {
    var p1: Player { get }
    var p2: Player { get }
    var board: Board! { get }
    func acceptMove(sender: BoardGameViewController, x: Int!, y: Int!) -> Bool
}

class TrapperExtremeGame: BoardGame {
    var p1: Player
    var p2: Player
    var board: Board!
    var currentSide: Bool!
    init(p1: Player, p2: Player, boardSize: Int) {
        self.p1 = p1
        self.p2 = p2
        self.board = Board(boardDimension: boardSize,initialValue: PieceType.EmptyCell)
        // p1's turn = true, p2's turn = false
        self.currentSide = true
    }
    
    func acceptMove(sender: BoardGameViewController, x: Int!, y: Int!) -> Bool {
        let move:Move!
        if self.currentSide! {
            if let human = p1 as? HumanPlayer {
                human.humanInput(sender, x: x, y: y)
            }
            move = p1.playMove()
        } else {
            if let human = p2 as? HumanPlayer {
                human.humanInput(sender, x: x, y: y)
            }
            move = p2.playMove()
        }
        let validMove = board.addPiece(move.player, x: move.x, y: move.y)
        if validMove {
            self.currentSide = !self.currentSide
        }
        //TODO
        return validMove
    }
}