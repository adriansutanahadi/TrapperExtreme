//
//  BoardPiece.swift
//  Trapper Extreme
//  Type of legal board Pieces
//  Created by Denis Thamrin on 18/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import SpriteKit

enum PieceType: Int,Printable {
    case Black = 0,White,CapturedEmptyCell,CapturedBlack,CapturedWhite,EmptyCell
    
    
    var spriteName: String {
        let spriteNames = [
            "Black",
            "White",
            "CapturedEmptyCell",
            "CapturedBlack",
            "CapturedWhite",
            "EmptyCell"]
        
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String{
        return spriteName + "-Highlighted"
    }
    
    var description: String{
        return spriteName
    }
}


// UI dependent Code
class BoardPiece : Printable{
    let x: Int
    let y: Int
    let pieceType: PieceType
    var sprite:SKSpriteNode?
    
    var description: String{
        return "type:\(pieceType) square:(\(x),\(y))"
    }
    
    init(x: Int,y: Int,pieceType:PieceType){
        self.x = x
        self.y = y
        self.pieceType = pieceType
    }
    
}
