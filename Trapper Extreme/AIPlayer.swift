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
        var moves: [Move]? = board.getMove(self.playerSide)
        if moves != nil {
            var move: Move
            var i = Int(arc4random_uniform(UInt32(moves!.count)))
            move = moves![i]
            return move
        } else {
            return nil
        }
    }
}

class MinimaxAIPlayer: AIPlayer {
    override func playMove(board: Board) -> Move? {
        if !board.isFinished() {
            var depth = 2
            return minimaxDecision(board, depth: depth)
        } else {
            return nil
        }
    }

    private func minimaxDecision(board: Board, depth: Int) -> Move? {
        var alpha = Int.min
        var beta = Int.max
        var bestScore = Int.min
        var bestMove: Move? = nil
        let moves: [Move]? = board.getMove(self.playerSide)
        if moves != nil {
            for move in moves! {
                var currentBoard = Board(board: board)
                currentBoard.addPiece(move)
                var currentMMValue = minimaxValue(currentBoard, depth: depth - 1, alpha: alpha, beta: beta, player: self.playerSide == PieceType.White ? PieceType.White : PieceType.Black)
                if currentMMValue > bestScore {
                    bestMove = move
                    bestScore = currentMMValue
                }
                alpha = max(alpha, bestScore)
                if beta <= alpha {
                    break
                }
            }
            return bestMove
        } else {
            return nil
        }
        
    }

    private func minimaxValue(state: Board, depth: Int, alpha: Int, beta: Int, player: PieceType) -> Int {
        let moves: [Move]? = state.getMove(player)
        if depth == 0 || moves == nil {
            return evaluate(state, side: player)
        }
        if player == PieceType.White {
            var bestScore = Int.min
            for move in moves! {
                var currentBoard = Board(board: state)
                currentBoard.addPiece(move)
                var currentMMValue = minimaxValue(currentBoard, depth: depth - 1, alpha: alpha, beta: beta, player: self.playerSide == PieceType.White ? PieceType.White : PieceType.Black)
                bestScore = max(bestScore, currentMMValue)
                if beta <= max(alpha, bestScore) {
                    break
                }
            }
            return bestScore
        } else {
            var bestScore = Int.max
            for move in moves! {
                var currentBoard = Board(board: state)
                currentBoard.addPiece(move)
                var currentMMValue = minimaxValue(currentBoard, depth: depth - 1, alpha: alpha, beta: beta, player: self.playerSide == PieceType.White ? PieceType.White : PieceType.Black)
                bestScore = min(bestScore, currentMMValue)
                if min(beta, bestScore) <= alpha {
                    break
                }
            }
            return bestScore
        }
    }
    
    private func evaluate(board: Board, side: PieceType) -> Int {
        if side == PieceType.White {
            return board.whiteScore - 3 * board.blackScore
        } else {
            return board.blackScore - 3 * board.whiteScore
        }
    }
}