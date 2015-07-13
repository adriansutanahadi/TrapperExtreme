//
//  Game.swift
//  Trapper Extreme
//
//  Created by Adrian Sutanahadi on 6/07/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

protocol BoardGame {
    var players: [Player] { get }
    var board: Board! { get }
    func acceptMove(sender: BoardGameViewController, x: Int!, y: Int!) -> Bool
}

class TrapperExtremeGame: BoardGame {
    var players: [Player]
    var board: Board!
    var turn: Int
    init(players: [Player], boardSize: Int) {
        self.board = Board(boardDimension: boardSize,initialValue: PieceType.EmptyCell)
        self.players = players
        self.turn = 0
    }
    
    func acceptMove(sender: BoardGameViewController, x: Int!, y: Int!) -> Bool {
        let move:Move!
        if let human = self.players[self.turn] as? HumanPlayer {
            human.humanInput(sender, x: x, y: y)
        }
        move = self.players[self.turn].playMove(self.board)
        let validMove = board.addPiece(move)
        if validMove {
            self.turn++
            if self.turn == players.count {
                self.turn = 0
            }
            if self.players[self.turn] as? AIPlayer != nil {
                acceptMove(sender, x: x, y: y)
            }
        }
        //TODO
        return validMove
    }
}