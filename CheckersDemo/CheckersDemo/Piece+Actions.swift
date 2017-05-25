//
//  Piece+Actions.swift
//  CheckersDemo
//
//  Created by projas on 5/24/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import UIKit

extension Piece {
  func canEat(Piece pieceToEat: Piece) -> Bool {
    
    if self.pieceColor == .red {
      
      
      guard RuleManager.boardLocation[self.boardPosition.row-2][self.boardPosition.column-2] == .free ||
        RuleManager.boardLocation[self.boardPosition.row+1][self.boardPosition.column+1] == .free
        else { return false }
      
      
      if (pieceToEat.boardPosition.column == self.boardPosition.column - 1 ||  pieceToEat.boardPosition.column == self.boardPosition.column + 1)
        && (pieceToEat.boardPosition.row == self.boardPosition.row - 1){
        return true
      }
      
    }else{
      
    }
    
    
    
    return false
  }
  
  func canMove(to position: BoardPosition) -> Bool {
    if self.pieceColor == .red {
      
      if RuleManager.boardLocation[position.row][position.column] == .free
        && (position.row == self.boardPosition.row - 1 ||  position.row == self.boardPosition.row + 1)
        && (position.column == self.boardPosition.column - 1 ||  position.column == self.boardPosition.column + 1) {
        return true
      }
      
      
    }else{
      
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
    RuleManager.boardLocation[position.row][position.column] = .taken
    
    self.boardPosition = position
    
    UIView.animate(withDuration: 0.3) {
      self.frame = RuleManager.boardCells[key]!.frame
    }
  }
  
}
