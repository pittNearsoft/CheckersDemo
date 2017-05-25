//
//  Piece.swift
//  CheckersDemo
//
//  Created by projas on 5/23/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import UIKit

class Piece: UIView {
  private var imageView = UIImageView()
  var boardPosition = BoardPosition(row: 0, column: 0)
  var pieceColor: PieceColor = .red
  
  init(WithBoardPosition position: BoardPosition,andColor color: PieceColor, onCellView cellView: UIView, boardView: UIView) {
    super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))

    self.pieceColor = color
    
    switch color {
    case .red:
      self.imageView = UIImageView(image: #imageLiteral(resourceName: "red"))
      
    case .blue:
      self.imageView = UIImageView(image: #imageLiteral(resourceName: "blue"))
    }

    self.addSubview(imageView)
    
    imageView.frame = self.frame
    imageView.frame.size.height = 50.0
    imageView.frame.size.width = 50.0
    imageView.center = self.center
    imageView.isUserInteractionEnabled = true
    
    self.frame.origin = cellView.frame.origin
    
    boardView.addSubview(self)
    
    self.boardPosition = position
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

typealias BoardPosition = (row: Int, column: Int)

enum PieceColor {
  case red
  case blue
}
