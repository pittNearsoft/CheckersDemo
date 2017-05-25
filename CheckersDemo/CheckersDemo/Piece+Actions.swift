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
      guard self.boardPosition.row == position.row + 2 && (self.boardPosition.column == position.column - 2 || self.boardPosition.column == position.column + 2)  else {
        return false
      }
      
      
      if position.row < 7 && position.column < 7 &&  RuleManager.boardLocation[position.row + 1][position.column + 1] == .blue
        && self.boardPosition.row == position.row + 2
        && self.boardPosition.column == position.column + 2{
        return true
      }
      
      if position.row < 7 && position.column > 0 &&  RuleManager.boardLocation[position.row + 1][position.column - 1] == .blue
        && self.boardPosition.row == position.row + 2
        && self.boardPosition.column == position.column - 2{
        return true
      }
      
    }else{
      guard self.boardPosition.row == position.row - 2 && (self.boardPosition.column == position.column - 2 || self.boardPosition.column == position.column + 2)  else {
        return false
      }
      
      if position.row > 0 && position.column < 7 &&  RuleManager.boardLocation[position.row - 1][position.column + 1] == .red
        && self.boardPosition.row == position.row - 2
        && self.boardPosition.column == position.column + 2{
        return true
      }
      
      if position.row > 0 && position.column > 0 && RuleManager.boardLocation[position.row - 1][position.column - 1] == .red
        && self.boardPosition.row  == position.row - 2
        && self.boardPosition.column == position.column - 2 {
        return true
      }
      
    }
    
    
    
    return false
  }
  
  func canEatAgain() -> Bool {
    
    if self.pieceColor == .red {
      
      if self.boardPosition.row > 1 && self.boardPosition.column > 1 && RuleManager.boardLocation[self.boardPosition.row - 1][self.boardPosition.column - 1] == .blue && RuleManager.boardLocation[self.boardPosition.row - 2][self.boardPosition.column - 2] == .free{
        return true
      }
      
      if self.boardPosition.row > 1 && self.boardPosition.column < 6 && RuleManager.boardLocation[self.boardPosition.row - 1][self.boardPosition.column + 1] == .blue && RuleManager.boardLocation[self.boardPosition.row - 2][self.boardPosition.column + 2] == .free{
        return true
      }
      
    }else{
      if self.boardPosition.row < 6 && self.boardPosition.column > 1 && RuleManager.boardLocation[self.boardPosition.row + 1][self.boardPosition.column - 1] == .red && RuleManager.boardLocation[self.boardPosition.row + 2][self.boardPosition.column - 2] == .free{
        return true
      }
      
      if self.boardPosition.row < 6 && self.boardPosition.column < 6 && RuleManager.boardLocation[self.boardPosition.row + 1][self.boardPosition.column + 1] == .red && RuleManager.boardLocation[self.boardPosition.row + 2][self.boardPosition.column + 2] == .free{
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
  
  private func eat(atPosition position: BoardPosition) {
    

    
    
    //Eating Red
    if position.row > 0 && position.column < 7 && RuleManager.boardLocation[position.row - 1][position.column + 1] == .red
      && self.boardPosition.row == position.row - 2
      && self.boardPosition.column == position.column + 2{
      
      RuleManager.boardLocation[position.row - 1][position.column + 1] = .free
      let piece = RuleManager.pieces.filter{ $0.boardPosition.row == position.row - 1 && $0.boardPosition.column == position.column + 1}.first!
      
      piece.removeFromBoard()
      
      let indexPiece = RuleManager.pieces.index(of: piece)
      RuleManager.pieces.remove(at: indexPiece!)
      
      return
    }
    
    if  position.row > 0 && position.column > 0 && RuleManager.boardLocation[position.row - 1][position.column - 1] == .red
      && self.boardPosition.row  == position.row - 2
      && self.boardPosition.column == position.column - 2 {
      RuleManager.boardLocation[position.row - 1][position.column - 1] = .free
      
      let piece = RuleManager.pieces.filter{ $0.boardPosition.row == position.row - 1 && $0.boardPosition.column == position.column - 1}.first!
      piece.removeFromBoard()
      let indexPiece = RuleManager.pieces.index(of: piece)
      RuleManager.pieces.remove(at: indexPiece!)

      return
    }
    
    //Eating blue
    if  position.row < 7 && position.column < 7 && RuleManager.boardLocation[position.row + 1][position.column + 1] == .blue
      && self.boardPosition.row == position.row + 2
      && self.boardPosition.column == position.column + 2{
      
      RuleManager.boardLocation[position.row + 1][position.column + 1] = .free
      
      let piece = RuleManager.pieces.filter{ $0.boardPosition.row == position.row + 1 && $0.boardPosition.column == position.column + 1}.first!
      piece.removeFromBoard()
      let indexPiece = RuleManager.pieces.index(of: piece)
      RuleManager.pieces.remove(at: indexPiece!)
      
      return
    }
    
    if  position.row < 7 && position.column > 0 && RuleManager.boardLocation[position.row + 1][position.column - 1] == .blue
      && self.boardPosition.row == position.row + 2
      && self.boardPosition.column == position.column - 2{
      
      RuleManager.boardLocation[position.row + 1][position.column - 1] = .free
      
      let piece = RuleManager.pieces.filter{ $0.boardPosition.row == position.row + 1 && $0.boardPosition.column == position.column - 1}.first!
      piece.removeFromBoard()
      let indexPiece = RuleManager.pieces.index(of: piece)
      RuleManager.pieces.remove(at: indexPiece!)
      
      return
    }
    
    
  }
  
  func eat(at position: BoardPosition) {
    
    eat(atPosition: position)
    move(to: position)
  }
  
  private func removeFromBoard(){
    UIView.animate(withDuration: 0.3, animations: {
      self.alpha = 0.0
    }, completion: { _ in
      self.removeFromSuperview()
    })
  }
  
}
