//
//  Engine.swift
//  CheckersDemo
//
//  Created by projas on 5/25/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import Foundation

class Engine {
  
//  func findBestMove(_ board: Board, player: BoardState, pieces: [Piece],  depth: Int = 7) -> (move: BoardPosition, piece: Piece, score: Int) {
////    let cpuPieces = RuleManager.pieces.filter { $0.pieceColor == .blue}
////    var bestScore = worstScore(player)
////    var bestMove = BoardPosition(row: -1, column: -1) // no move yet
//    
//    if player == .blue {
//      
//      
//      for piece in pieces {
//        
//        let newPosition = BoardPosition(row: piece.boardPosition.row + 1, column: piece.boardPosition.column - 1)
//        
//        if piece.canMove(to: newPosition) {
//          
//        }else if piece.canEat(in: newPosition){
//          
//        }
//        
//      }
//      
//    }
//    
//    
//    
//    
//  }
//  
//
//  
//  fileprivate func utility(_ board: Board, player: BoardState) -> Double {
//    let numberOfReds: Double = Double(board.flatMap{ $0 }.filter { $0 == .red }.count)
//    let numberOfBlues: Double = Double(board.flatMap{ $0 }.filter { $0 == .blue }.count)
//
//    
//    return (numberOfReds-numberOfBlues)/(numberOfReds+numberOfBlues)
//  }
//  
//  fileprivate func getOpponentBestMove(_ player: BoardState, board: Board, depth: Int = 0) -> (move: BoardPosition, piece: Piece, score: Int) {
//    if player == .blue {
//      return findBestMove(board, player: .red, depth: depth + 1)
//    } else {
//      return findBestMove(board, player: .blue, depth: depth + 1)
//    }
//  }
//  
//  fileprivate func isBetterScore(_ player: BoardState, score: Int, bestScore: Int) -> Bool {
//    if player == .blue {
//      return score > bestScore
//    } else {
//      return score < bestScore
//    }
//  }

}
