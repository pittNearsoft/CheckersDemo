//
//  ViewController.swift
//  CheckersDemo
//
//  Created by projas on 5/22/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let numViewPerRow = 8
  var selectedView: UIView?
  let width: CGFloat = 80
  var piecesRed: [Piece] = []
  
  var piecesBlue: [Piece] = []
  
  let numberOfPiecesPerColor  = 12
  var boardView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    var indexRed = 0
    var indexBlue = 0
    
    boardView = UIView(frame: CGRect(x: 50, y: 50, width: width*8, height: width*8 ))
    self.view.addSubview(boardView)
    
    
    for row in 0..<8 {
      for column in 0..<numViewPerRow {

        let boardCell = createBoardCell(inRow: row, column: column)
        
        if boardCell.backgroundColor == .black {
          addBackground(ToBoardCell: boardCell)
        }else{
          if indexBlue < numberOfPiecesPerColor && row <= 2{
            addPieceToBoard(WithColor: .blue, position: BoardPosition(row: row, column: column), onBoardCell: boardCell)
            indexBlue += 1
          }else if indexRed < numberOfPiecesPerColor && row >= 5 {
            addPieceToBoard(WithColor: .red, position: BoardPosition(row: row, column: column), onBoardCell: boardCell)
            indexRed += 1
          }
        }

        
        let key = "\(column)|\(row)"
        RuleManager.boardCells[key] = boardCell
      }
    }
    
    bringPiecesToFront()
    
  }
  
  
  // MARK: - Gesture Methods
  func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {

    let piece = gestureRecognizer.view! as! Piece
    
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
      view.bringSubview(toFront: piece)
      
      
      let translation = gestureRecognizer.translation(in: self.view)
      // note: 'view' is optional and need to be unwrapped
      piece.center = CGPoint(x: piece.center.x + translation.x, y: piece.center.y + translation.y)
      gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    }else if gestureRecognizer.state == .ended{
      let location = gestureRecognizer.location(in: boardView)
      
      
      //Validates chip is within board area
      guard location.x >= 0 && location.x <= width*8 else {
        piece.returnToOriginalPosition()
        return
      }
      
      //Validates chip is within board area
      guard location.y >= 0 && location.y <= width*8 else {
        piece.returnToOriginalPosition()
        return
      }
      
      
      let column = Int(location.x / width)
      let row = Int(location.y / width)
      
      let key = "\(column)|\(row)"
      
      print(key)
      
      guard let cellView = RuleManager.boardCells[key]
        else {
          piece.returnToOriginalPosition()
          return
      }
      
      
      let position = BoardPosition(row: row, column: column)
      if piece.canMove(to: position) {
        piece.move(to: position)
        
      }else{
        piece.returnToOriginalPosition()
      }

      
    }
  }
  
  //MARK: - Helpers
  func bringPiecesToFront() {
    for piece in piecesBlue {
      view.bringSubview(toFront: piece)
    }
    
    for piece in piecesRed {
      view.bringSubview(toFront: piece)
    }
  }
  
  func addPieceToBoard(WithColor color: PieceColor, position: BoardPosition, onBoardCell boardCell: UIView) {
    let piece = Piece(WithBoardPosition: position, andColor: color, onCellView: boardCell, boardView: self.view)
    piecesRed.append(piece)
    piece.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
  }
  
  func createBoardCell(inRow row: Int, column: Int) -> UIView {
    let boardCell = UIView()
    boardCell.backgroundColor =  ((column%2 == 0 && row%2==1) || (column%2 == 1 && row%2==0)) ? .black : .white
    boardCell.frame = CGRect(x: CGFloat(column)*width + 50, y: CGFloat(row)*width  + 50, width: width, height: width)
    boardCell.layer.borderWidth = 0.5
    boardCell.layer.borderColor = UIColor.black.cgColor
    view.addSubview(boardCell)
    
    return boardCell
  }
  
  func addBackground(ToBoardCell boardCell: UIView) {
    let background = UIImageView(frame: boardCell.frame)
    background.image = #imageLiteral(resourceName: "wood")
    background.frame.origin = CGPoint(x: 0, y: 0)
    boardCell.addSubview(background)
  }
  
}
