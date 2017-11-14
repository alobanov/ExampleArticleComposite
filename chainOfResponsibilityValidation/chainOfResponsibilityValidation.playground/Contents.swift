//: Playground - noun: a place where people can play

import UIKit

enum MiddlewareItem {
  case value(String?)
  case error(String)
}

protocol MiddlewareProtocol {
  var identifier: String {get}
  @discardableResult func link(with: MiddlewareProtocol) -> MiddlewareProtocol
  func check(value: MiddlewareItem) -> MiddlewareItem
  func checkNext(value: MiddlewareItem) -> MiddlewareItem
}

class Middleware: MiddlewareProtocol {
  var next: MiddlewareProtocol?
  var identifier: String = ""
  
  @discardableResult func link(with: MiddlewareProtocol) -> MiddlewareProtocol {
    self.next = with
    return with
  }
  
  func check(value: MiddlewareItem) -> MiddlewareItem {
    return checkNext(value: value)
  }
  
  func checkNext(value: MiddlewareItem) -> MiddlewareItem {
    guard let next = self.next else {
      return value
    }
    
    return next.check(value: value)
  }
}

class NilValidation: Middleware {
  override func check(value: MiddlewareItem) -> MiddlewareItem {
    switch value {
    case .value(let str):
      if str == nil {
        return .error("Значение равно nil")
      }
    default: break
    }
    
    return checkNext(value: value)
  }
}

class CountValidation: Middleware {
  private let length: Int
  
  init(length: Int) {
    self.length = length
  }
  
  override func check(value: MiddlewareItem) -> MiddlewareItem {
    switch value {
    case .value(let str):
      if str?.count != length {
        return .error("Длинна должна быть \(length)")
      }
    default: break
    }
    
    return checkNext(value: value)
  }
}

class PhoneFormatterValidation: Middleware {
  private let format: String // "+X (XXX) XXX XX-XX"
  
  init(format: String) {
    self.format = format
  }
  
  override func check(value: MiddlewareItem) -> MiddlewareItem {
    switch value {
    case .value(let str):
      if let s = str {
        
        let cleanPhoneNumber = s.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = format
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
          if index == cleanPhoneNumber.endIndex {
            break
          }
          if ch == "X" {
            result.append(cleanPhoneNumber[index])
            index = cleanPhoneNumber.index(after: index)
          } else {
            result.append(ch)
          }
        }
        return .value(result)
      }
    default: break
    }
    
    return checkNext(value: value)
  }
}

func <<(lhs: MiddlewareProtocol, rhs: MiddlewareProtocol) -> MiddlewareProtocol {
  let res = (lhs.link(with: rhs))
  return res
}

let start = Middleware()
//((start
//  << NilValidation())
//  << CountValidation(length: 11))
//  << PhoneFormatterValidation(format: "+X (XXX) XXX XX-XX")

start
  .link(with: NilValidation())
  .link(with: CountValidation(length: 11))
  .link(with: PhoneFormatterValidation(format: "+X (XXX) XXX XX-XX"))


let r = start.check(value: .value("79634480209"))


switch r {
case .error(let error):
  print(error)
case .value(let result):
  print(result ?? "")
}






