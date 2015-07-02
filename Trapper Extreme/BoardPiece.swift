//
//  BoardPiece.swift
//  Trapper Extreme
//  Type of legal board Pieces
//  Created by Denis Thamrin on 18/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import SpriteKit

enum PieceType: Int,Printable {
    case Black,White,CapturedEmptyCell,CapturedBlack,CapturedWhite,EmptyCell
    
    
    var spriteName: String {
        let spriteNames = [
            "Black",
            "White",
            "CapturedEmptyCell",
            "CapturedBlack",
            "CapturedWhite",
            "EmptyCell"]
        
        return spriteNames[rawValue]
    }
    
    var highlightedSpriteName: String{
        return spriteName + "-Highlighted"
    }
    
    var description: String{
        return spriteName
    }
}


//// UI dependent Code
class BoardPiece {

    var pieceType: PieceType {
        willSet {
            self.sprite?.texture =  SKTexture(imageNamed: newValue.spriteName)

            //setSprite(oldValue)
        }
    }
    var sprite:SKSpriteNode?

    
    init(pieceType: PieceType){
        self.pieceType = pieceType
        self.sprite =  SKSpriteNode(imageNamed: pieceType.spriteName)

    }
    
//    private func setSprite(p:PieceType) {
//        self.sprite =  SKSpriteNode(imageNamed: p.spriteName)
//    }

}
