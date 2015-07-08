//
//  Board.swift
//  Trapper Extreme
//  Board encapsulates the game state of the board
//  Created by Denis Thamrin and Adrian Sutanahadi on 18/06/2015.
//  Copyright (c) 2015 Denis Thamrin. All rights reserved.
//

import Foundation

// Structs

struct Point {
    var x: Int
    var y: Int
    func isEqual(p: Point) -> Bool {
        if x == p.x && y == p.y {
            return true
        } else {
            return false
        }
    }
}


struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    func isEmpty() -> Bool {
        return items.isEmpty
    }
}
        
class Board{
    //Private setter
    private(set) var board: [[BoardPiece?]]!
    private(set) var whiteScore: Int
    private(set) var blackScore: Int
    private(set) var emptyCellCount: Int
    private(set) var capturedCellsMap: [(point: Point, owner: PieceType)]
    
    let boardDimension: Int
    
    init(boardDimension:Int,initialValue:PieceType!){
        self.boardDimension = boardDimension

        self.board = Array(count:boardDimension, repeatedValue:Array(count:boardDimension, repeatedValue: nil))
        for x in 0...boardDimension-1 {
            for y in 0...boardDimension-1 {
                let initialPiece = BoardPiece(pieceType: initialValue)
                self.board[x][y] = initialPiece
            }
        }
        self.whiteScore = 0
        self.blackScore = 0
        self.emptyCellCount = boardDimension * boardDimension
        self.capturedCellsMap = []
    }
    
    init(b: Board) {
        self.boardDimension = b.boardDimension
        
        self.board = Array(count:self.boardDimension, repeatedValue:Array(count:self.boardDimension, repeatedValue: nil))
        for x in 0...self.boardDimension-1 {
            for y in 0...self.boardDimension-1 {
                let initialPiece = BoardPiece(pieceType: b.board[x][y]!.pieceType)
                self.board[x][y] = initialPiece
            }
        }
        self.whiteScore = b.whiteScore
        self.blackScore = b.blackScore
        self.emptyCellCount = b.emptyCellCount
        self.capturedCellsMap = b.capturedCellsMap
    }
    
    // Index starts from 0,0 . x axis left to right,y axis up to down.
    // Need to add more constraint, such as piece must beeiter Black or White ???
    // If legal return true,else false
    func addPiece(piece:PieceType!,x:Int, y:Int) -> Bool{
        if self.board[x][y]!.pieceType == PieceType.EmptyCell {
            self.board[x][y]!.pieceType = piece
            self.emptyCellCount -= 1
            updateBoard(Point(x: x, y: y), player: piece)
            updateScore()
            return true
        } else {
            return false
        }
    }
    
    func isFinished() -> Bool {
        return self.emptyCellCount == 0
    }
    
//    func isCaptured(c: PieceType) -> Bool {
//        if c == PieceType.CapturedBlack || c == PieceType.CapturedEmptyCell || c == PieceType.CapturedWhite {
//            return true
//        } else {
//            return false
//        }
//    }
    
    private func checkCellValidity(p: Point) -> Bool{
        if p.x < 0 || p.x >= self.boardDimension || p.y < 0 || p.y >= self.boardDimension {
            return false
        } else {
            return true
        }
    }
    
    private func updateBoard(p: Point, player: PieceType) {
        let topTile = Point(x: p.x, y: p.y-1)
        let leftTile = Point(x: p.x-1, y: p.y)
        let bottomTile = Point(x: p.x, y: p.y+1)
        let rightTile = Point(x: p.x+1, y: p.y)
        let capturedTop = floodFill(topTile, player: player)
        let capturedLeft = floodFill(leftTile, player: player)
        let capturedBottom = floodFill(bottomTile, player: player)
        let capturedRight = floodFill(rightTile, player: player)
        let capturedTiles = capturedTop + capturedLeft + capturedBottom + capturedRight
        for tile in capturedTiles {
            let piece = board[tile.x][tile.y]!.pieceType
            if player == PieceType.White {
                switch piece {
                case PieceType.EmptyCell:
                    board[tile.x][tile.y]!.pieceType = PieceType.CapturedEmptyCell
                    capturedCellsMap.append((point: tile, owner: player))
                    self.emptyCellCount -= 1
                case PieceType.Black:
                    board[tile.x][tile.y]!.pieceType = PieceType.CapturedBlack
                    capturedCellsMap.append((point: tile, owner: player))
                case PieceType.CapturedWhite:
                    board[tile.x][tile.y]!.pieceType = PieceType.White
                    capturedCellsMap = capturedCellsMap.filter({!$0.point.isEqual(tile)})
                default:
                    break   
                }
            } else if player == PieceType.Black {
                switch piece {
                case PieceType.EmptyCell:
                    board[tile.x][tile.y]!.pieceType = PieceType.CapturedEmptyCell
                    capturedCellsMap.append((point: tile, owner: player))
                    self.emptyCellCount -= 1
                case PieceType.White:
                    board[tile.x][tile.y]!.pieceType = PieceType.CapturedWhite
                    capturedCellsMap.append((point: tile, owner: player))
                case PieceType.CapturedBlack:
                    board[tile.x][tile.y]!.pieceType = PieceType.Black
                    capturedCellsMap = capturedCellsMap.filter({!$0.point.isEqual(tile)})
                default:
                    break
                }
            }
        }
    }

    private func floodFill(p: Point, player: PieceType) -> [Point] {
        var processedPoints: [Point] = []
        if !checkCellValidity(p) || self.board[p.x][p.y]!.pieceType == player {
            return []
        }
        
        // define the 4 directions
        let n = Point(x: 0, y: -1)
        let e = Point(x: 1, y: 0)
        let s = Point(x: 0, y: 1)
        let w = Point(x: -1, y: 0)
        let directions = [n, e, s, w]
        
        var queue = Stack<Point>()
        queue.push(p)
        while(!queue.isEmpty()) {
            let currentPosition = queue.pop()
            if board[currentPosition.x][currentPosition.y]!.pieceType != player {
                processedPoints += [currentPosition]
                for dir in directions {
                    let nextPosition = Point(x: currentPosition.x + dir.x, y: currentPosition.y + dir.y)
                    let isValid = checkCellValidity(nextPosition)
                    if !isValid {
                        return []
                    }
                    let notProcessedPreviously = processedPoints.filter({$0.isEqual(nextPosition)}).count == 0
                    if isValid && notProcessedPreviously {
                        queue.push(nextPosition)
                    }
                }
            }
        }
        return processedPoints
    }
    
    // update the score
    private func updateScore() {
        var blackScore = 0
        var whiteScore = 0
        
        for cell in self.capturedCellsMap {
            if cell.owner == PieceType.Black {
                blackScore += 1
            } else if cell.owner == PieceType.White {
                whiteScore += 1
            }
        }
        self.blackScore = blackScore
        self.whiteScore = whiteScore
    }
    
//    // check the ownership of the captured cell
//    func checkCapturedCell(p: Point) -> PieceType {
//        var surroundingCell: [PieceType] = []
//        if board[p.x][p.y] == PieceType.CapturedBlack {
//            return PieceType.White
//        }
//        if board[p.x][p.y] == PieceType.CapturedWhite {
//            return PieceType.Black
//        }
//        
//        
//        // define the 4 directions
//        let n = Point(x: 0, y: -1)
//        let e = Point(x: 1, y: 0)
//        let s = Point(x: 0, y: 1)
//        let w = Point(x: -1, y: 0)
//        let directions = [n, e, s, w]
//        
//        // check the surrounding cells in 4 directions
//        for dir in directions {
//            var check = Point(x: p.x, y: p.y)
//            check.x += dir.x
//            check.y += dir.y
//            while (checkCellValidity(check)) {
//                switch board[check.x][check.y] {
//                case PieceType.CapturedBlack:
//                    return PieceType.White
//                case PieceType.CapturedWhite:
//                    return PieceType.Black
//                case PieceType.CapturedEmptyCell:
//                    check.x += dir.x
//                    check.y += dir.y
//                default:
//                    surroundingCell.append(board[check.x][check.y])
//                    break
//                }
//            }
//        }
//        
//        // determine the owner
//        var owner: Int = 0
//        for c in surroundingCell {
//            if c == PieceType.White {
//                owner += 1
//            } else if c == PieceType.Black {
//                owner -= 1
//            }
//        }
//        if owner == -4 {
//            return PieceType.Black
//        } else if owner == 4 {
//            return PieceType.White
//        } else {
//            return PieceType.EmptyCell
//        }
//    }
}
