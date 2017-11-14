//
//  CompoudItemProtocol.swift
//  TableComposite
//
//  Created by Lobanov Aleksey on 03/11/2017.
//  Copyright © 2017 Lobanov Aleksey. All rights reserved.
//

import Foundation

// уровень вложенности
enum CompoundItemLevel {
  case root, section, item
}

protocol CompoundItemProtocol {
  // уникальный идентификатор
  var identifier: String {get}
  // уровень на котором находится элемент
  var level: CompoundItemLevel {get}
  // дочерние элементы дерева
  var children: [CompoundItemProtocol] {get}
  // список элементов для работы
  var items: [CompoundItemProtocol] {get}
  // добавить дечерний элемент
  func add(_ model: CompoundItemProtocol...)
  // удалить дочерний элемент
  func remove(_ model: CompoundItemProtocol)
}

func == (lhs: CompoundItemProtocol, rhs: CompoundItemProtocol) -> Bool {
  return lhs.identifier == rhs.identifier
}
