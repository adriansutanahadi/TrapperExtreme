//
//  AIPlayer.swift
//  Trapper Extreme
//
//  Created by Adrian Sutanahadi on 7/07/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

class AIPlayer: GenericPlayer {
    override func playMove(board: Board) -> Move? {
        if !board.isFinished() {
            var move: Move?
            var x = Int(arc4random_uniform(UInt32(board.boardDimension)))
            var y = Int(arc4random_uniform(UInt32(board.boardDimension)))
            while board.board[x][y]!.pieceType != PieceType.EmptyCell {
                x = Int(arc4random_uniform(UInt32(board.boardDimension)))
                y = Int(arc4random_uniform(UInt32(board.boardDimension)))
            }
            move = Move(x: x, y: y, player: self.playerSide)
            return move
        } else {
            return nil
        }
    }
}
