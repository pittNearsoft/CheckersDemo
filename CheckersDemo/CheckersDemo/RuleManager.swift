//
//  RuleManager.swift
//  CheckersDemo
//
//  Created by projas on 5/23/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import UIKit

typealias Board = [[BoardState]]

class RuleManager {
  static var boardLocation: Board = [[.blue,  .unused, .blue,   .unused, .blue,   .unused, .blue,   .unused],
                                                [.unused, .blue,   .unused, .blue,   .unused, .blue,   .unused, .blue],
                                                [.blue,   .unused, .blue,   .unused, .blue,   .unused, .blue,   .unused],
                                                [.unused, .free,   .unused, .free,   .unused, .free,   .unused, .free],
                                                [.free,   .unused, .free,   .unused, .free,   .unused, .free,   .unused],
                                                [.unused, .red,    .unused, .red,    .unused, .red,    .unused, .red],
                                                [.red,    .unused, .red,    .unused, .red,    .unused, .red,    .unused],
                                                [.unused, .red,    .unused, .red,    .unused, .red,    .unused, .red]]
  
  
  static var boardCells = [String: UIView]()
  
  static var pieces: [Piece] = []
  
}

enum BoardState {
  case blue
  case red
  case free
  case unused
}
