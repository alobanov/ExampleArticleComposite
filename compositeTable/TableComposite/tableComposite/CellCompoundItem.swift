//
//  CellCompoundItem.swift
//  TableComposite
//
//  Created by Lobanov Aleksey on 03/11/2017.
//  Copyright © 2017 Lobanov Aleksey. All rights reserved.
//

import Foundation

protocol CellCompoundItemProtocol {
  var title: String? {get}
  var subtitle: String? {get}
  var cellIdentifier: String {get}
}

class CellCompoundItem: CompoundItemProtocol, CellCompoundItemProtocol {
  private let decoratedComposite: CompoundItemProtocol
  var title: String?
  var subtitle: String?
  let cellIdentifier: String
  
  var identifier: String {
    return self.decoratedComposite.identifier
  }
  
  var children: [CompoundItemProtocol] {
    return []
  }
  
  var items: [CompoundItemProtocol] {
    return [self]
  }
  
  var level: CompoundItemLevel {
    return self.decoratedComposite.level
  }
  
  init(identifier: String, cellIdentifier: String, title: String?, subtitle: String?) {
    self.decoratedComposite = BaseCompoundItem(identifier: identifier, level: .item)
    self.title = title
    self.subtitle = subtitle
    self.cellIdentifier = cellIdentifier
  }
  
  func add(_ model: CompoundItemProtocol...) {
    print("Нельзя добавить дочерние элементов, этот элемент является листом структуры")
  }
  
  func remove(_ model: CompoundItemProtocol) {
    print("У листьев нет детей, нечего удалять")
  }
}
