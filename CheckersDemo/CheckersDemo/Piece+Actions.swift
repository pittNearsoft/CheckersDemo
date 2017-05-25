//
//  Piece+Actions.swift
//  CheckersDemo
//
//  Created by projas on 5/24/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import UIKit

extension Piece {
  func canEat(in position: BoardPosition) -> Bool {
    guard RuleManager.boardLocation[position.row][position.column] == .free
      else{ return false }
    
    if self.pieceColor == .red {
      
      if RuleManager.boardLocation[position.row - 1][position.column + 1] == .blue || RuleManager.boardLocation[position.row - 1][position.column - 1] == .blue {
        return true
      }
      
    }else{
      if RuleManager.boardLocation[position.row + 1][position.column + 1] == .red || RuleManager.boardLocation[position.row + 1][position.column - 1] == .red {
        return true
      }
    }
    
    
    
    return false
  }
  
  func canMove(to position: BoardPosition) -> Bool {

    guard RuleManager.boardLocation[position.row][position.column] == .free
      else{ return false }
    
    if self.pieceColor == .red {
      
      if position.row == self.boardPosition.row - 1 && (position.column == self.boardPosition.column - 1 || position.column == self.boardPosition.column + 1) {
        return true
      }
      
    }else{
      if position.row == self.boardPosition.row + 1 && (position.column == self.boardPosition.column - 1 || position.column == self.boardPosition.column + 1) {
        return true
      }
    }
    
    return false
  }
  
  func returnToOriginalPosition() {
    let key = "\(self.boardPosition.column)|\(self.boardPosition.row)"
    
    
    UIView.animate(withDuration: 0.3) {
      self.frame = RuleManager.boardCells[key]!.frame
    }
  }
  
  func move(to position: BoardPosition) {
    let key = "\(position.column)|\(position.row)"
    
    
    RuleManager.boardLocation[self.boardPosition.row][self.boardPosition.column] = .free
    RuleManager.boardLocation[position.row][position.column] = (self.pieceColor == .red) ? .red : .blue
    
    self.boardPosition = position
    
    UIView.animate(withDuration: 0.3) {
      self.frame = RuleManager.boardCells[key]!.frame
    }
  }
  
  private func eat(Piece piece: Piece) {
    
  }
  
  func move(to position: BoardPosition, AndEatPiece piece: Piece) {
    move(to: position)
    eat(Piece: piece)
  }
  
}
