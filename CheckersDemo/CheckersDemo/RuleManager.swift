//
//  RuleManager.swift
//  CheckersDemo
//
//  Created by projas on 5/23/17.
//  Copyright © 2017 nearsoft. All rights reserved.
//

import UIKit

class RuleManager {
  static var boardLocation: [[BoardLocation]] = [[.taken,  .unused, .taken,  .unused, .taken,  .unused, .taken,  .unused],
                                          [.unused, .taken,  .unused, .taken,  .unused, .taken,  .unused, .taken],
                                          [.taken,  .unused, .taken,  .unused, .taken,  .unused, .taken,  .unused],
                                          [.unused, .free,   .unused, .free,   .unused, .free,   .unused, .free],
                                          [.free,   .unused, .free,   .unused, .free,   .unused, .free,   .unused],
                                          [.unused, .taken,  .unused, .taken,  .unused, .taken,  .unused, .taken],
                                          [.taken,  .unused, .taken,  .unused, .taken,  .unused, .taken,  .unused],
                                          [.unused, .taken,  .unused, .taken,  .unused, .taken,  .unused, .taken]]
  
  
  static var boardCells = [String: UIView]()
  
}

enum BoardLocation {
  case taken
  case free
  case unused
}
