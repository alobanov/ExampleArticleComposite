//
//  BaseCompoundItem.swift
//  TableComposite
//
//  Created by Lobanov Aleksey on 03/11/2017.
//  Copyright © 2017 Lobanov Aleksey. All rights reserved.
//

import Foundation

class BaseCompoundItem: CompoundItemProtocol {
  var children: [CompoundItemProtocol] = []
  
  var items: [CompoundItemProtocol] {
    return children
  }
  
  let level: CompoundItemLevel
  let identifier: String
  
  init() {
    self.identifier = "root"
    self.level = .root
  }
  
  init(identifier: String, level: CompoundItemLevel) {
    self.identifier = identifier
    self.level = level
  }
  
  func add(_ model: CompoundItemProtocol...) {
    self.children.append(contentsOf: model)
  }
  
  func remove(_ model: CompoundItemProtocol) {
    if let index = self.children.index(where: { $0 == model }) {
      children.remove(at: index)
    }
  }
}
