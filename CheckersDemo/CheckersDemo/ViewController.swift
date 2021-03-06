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
  
  let numberOfPiecesPerColor  = 12
  var boardView = UIView()
  
  var vsComputer = true
  let cpu = ComputerPlayer()
  
  @IBOutlet weak var turnForLabel: UILabel!
  
  var currentTurn = PieceColor.red
  @IBOutlet weak var currentTurnLabel: UILabel!
		
  let listMovesCPU = [BoardPosition(row: 3, column: 3),
                      BoardPosition(row: 3, column: 3),
                      BoardPosition(row: 5, column: 5),
                      BoardPosition(row: 3, column: 5),
                      BoardPosition(row: 3, column: 5),
                      BoardPosition(row: 5, column: 7),
                      BoardPosition(row: 7, column: 5),
                      BoardPosition(row: 5, column: 3)]
  
  let listOriginCPU = [BoardPosition(row: 2, column: 2),
                       BoardPosition(row: 1, column: 1),
                       BoardPosition(row: 3, column: 3),
                       BoardPosition(row: 2, column: 6),
                       BoardPosition(row: 1, column: 7),
                       BoardPosition(row: 3, column: 5),
                       BoardPosition(row: 5, column: 7),
                       BoardPosition(row: 7, column: 5)]
  
  var cpuTurn = 0
  
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
    
    guard piece.pieceColor == currentTurn || (currentTurn == .blue && vsComputer) else {
      return
    }
    
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
      
      guard RuleManager.boardCells[key] != nil
        else {
          piece.returnToOriginalPosition()
          return
      }
      
      
      let position = BoardPosition(row: row, column: column)
      if piece.canMove(to: position) {
        piece.move(to: position)
        changeTurn()
      }else if piece.canEat(in: position){
        piece.eat(at: position)
        
        if !piece.canEatAgain() {
          checkIfGameEnds()
        }
        
        
      }else{
        piece.returnToOriginalPosition()
      }

      if currentTurn == .blue && vsComputer && cpuTurn < listMovesCPU.count {
//        let bestMove: BoardPosition
//        let bestPiece: Piece
//        let board = RuleManager.boardLocation
//        (bestMove, bestPiece, _) = cpu.engine.findBestMove(board, player: .blue)
//        validateCPUMove(WithPosition: bestMove, andPiece: bestPiece)
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4 , execute: {
          let cpuPiece = RuleManager.pieces.filter{ $0.boardPosition.row == self.listOriginCPU[self.cpuTurn].row && $0.boardPosition.column == self.listOriginCPU[self.cpuTurn].column }.first!
          
          self.validateCPUMove(WithPosition: self.listMovesCPU[self.cpuTurn], andPiece: cpuPiece)
          self.cpuTurn += 1
          
          if self.currentTurn == .blue{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2 , execute: {
              let cpuPiece = RuleManager.pieces.filter{ $0.boardPosition.row == self.listOriginCPU[self.cpuTurn].row && $0.boardPosition.column == self.listOriginCPU[self.cpuTurn].column }.first!
              
              self.validateCPUMove(WithPosition: self.listMovesCPU[self.cpuTurn], andPiece: cpuPiece)
              self.cpuTurn += 1
              
              
            })
          }
        })
        
        
      }
      
      
      
    }
  }
  
  //MARK: - Helpers
  func validateCPUMove(WithPosition position: BoardPosition, andPiece piece: Piece) {

    if piece.canMove(to: position) {
      piece.move(to: position)
      changeTurn()
    }else if piece.canEat(in: position){
      piece.eat(at: position)
      
      if !piece.canEatAgain() {
        checkIfGameEnds()
      }
      
      
    }
  }
  
  
  func changeTurn() {
    
    let pieces = RuleManager.pieces.filter { $0.pieceColor == currentTurn}
    
    for piece in pieces {
      piece.isUserInteractionEnabled = false
    }

    if currentTurn == .red {
      currentTurn = .blue
      currentTurnLabel.textColor = .blue
      currentTurnLabel.text = "Blue"
    }else{
      currentTurn = .red
      currentTurnLabel.textColor = .red
      currentTurnLabel.text = "Red"
    }
    
    
    
    let opponentPieces = RuleManager.pieces.filter { $0.pieceColor == currentTurn}
    
    for piece in opponentPieces {
      piece.isUserInteractionEnabled = true
    }
  }
  
  func checkIfGameEnds() {
    
    changeTurn()
    
    let pieces = RuleManager.pieces.filter { $0.pieceColor == currentTurn}
    
    if pieces.count == 0 {
      let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        // ...
      }
      
      let message = (currentTurn == .red) ? "Blue Wins!" : "Red Wins!"
      
      turnForLabel.text = message
      currentTurnLabel.text = ""
      
      let alert = UIAlertController(title: "Game Over!", message: message, preferredStyle: .alert)
      alert.addAction(OKAction)
      
      present(alert, animated: true, completion: nil)
    }
  }
  
  func bringPiecesToFront() {
    for piece in RuleManager.pieces {
      view.bringSubview(toFront: piece)
    }
  }
  
  func addPieceToBoard(WithColor color: PieceColor, position: BoardPosition, onBoardCell boardCell: UIView) {
    let piece = Piece(WithBoardPosition: position, andColor: color, onCellView: boardCell, boardView: self.view)
    RuleManager.pieces.append(piece)
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

