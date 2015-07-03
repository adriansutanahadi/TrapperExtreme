//
//  Player.swift
//  Trapper Extreme
//  Player implementation that plays the game
//  Created by Denis Thamrin on 2/07/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

struct Move {
    let x:Int
    let y:Int
    var player:PieceType {
        willSet {
            if GenericPlayer.isLegalPieceType(newValue) {
                self.player = newValue
            }
        }
    }
    

}

protocol Player {
    var playerSide:PieceType! {get }
    func playMove()->Move?
    static func isLegalPieceType(p:PieceType) -> Bool
}

class GenericPlayer:Player {
    let playerSide:PieceType!
    init(player:PieceType){
        if GenericPlayer.isLegalPieceType(player){
            self.playerSide = player
        } else {
            self.playerSide = nil
        }
        assert(self.playerSide != nil, "Player Side can't be nil, make sure it's either PieceType.Black/White")
    }
    
    func playMove() -> Move? {
        assert(false,"Shouldn't really initialize this class as it can't make a move")
        return nil
    }
    
    static  func isLegalPieceType(piece : PieceType) -> Bool{
        if (piece == PieceType.Black || piece == PieceType.White) {
            return true
        } else {
            return false
        }
    }
}

class HumanPlayer:GenericPlayer,HumanInputDelegate {
    var move:Move?
    func humanInput(sender: BoardGameViewController, x: Int, y: Int) {
        self.move = Move(x:x,y:y,player:playerSide)
    }
    
    override func playMove() -> Move? {
        return move
    }
}
