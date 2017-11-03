//
//  SectionItem.swift
//  TableComposite
//
//  Created by Lobanov Aleksey on 03/11/2017.
//  Copyright © 2017 Lobanov Aleksey. All rights reserved.
//

import Foundation

protocol SectionCompoundItemProtocol {
  var header: String? {get}
  var footer: String? {get}
}

class SectionCompoundItem: CompoundItemProtocol, SectionCompoundItemProtocol {
  private let decoratedComposite: CompoundItemProtocol
  var header: String?
  var footer: String?
  
  var identifier: String {
    return self.decoratedComposite.identifier
  }
  
  var children: [CompoundItemProtocol] {
    return self.decoratedComposite.children
  }
  
  var items: [CompoundItemProtocol] {
    return self.decoratedComposite.children.flatMap {$0.items}
  }
  
  var level: CompoundItemLevel {
    return self.decoratedComposite.level
  }
  
  init(identifier: String, header: String?, footer: String?) {
    self.decoratedComposite = BaseCompoundItem(identifier: identifier, level: .section)
    self.header = header
    self.footer = footer
  }
  
  func add(_ model: CompoundItemProtocol...) {
    for item in model {
      if item.level != .section {
        self.decoratedComposite.add(item)
      } else {
        print("You can`t add section in other section")
      }
    }
  }
  
  func remove(_ model: CompoundItemProtocol) {
    self.decoratedComposite.remove(model)
  }
}
