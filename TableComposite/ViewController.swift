//
//  ViewController.swift
//  TableComposite
//
//  Created by Lobanov Aleksey on 03/11/2017.
//  Copyright © 2017 Lobanov Aleksey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var datasource: CompoundItemProtocol = BaseCompoundItem()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.delegate = self
    tableView.dataSource = self
    
    self.datasource = BaseCompoundItem()
    
    let section1 = SectionCompoundItem(identifier: "Section1", header: "Вселенная MARVEL", footer: "Marvel Comics — американская компания, издающая комиксы, подразделение корпорации «Marvel Entertainment»")
    let section2 = SectionCompoundItem(identifier: "Section2", header: "Вселенная DC", footer: "DC Comics — одно из крупнейших и наиболее популярных издательств комиксов, наравне с Marvel Comics")
    
    let spider = CellCompoundItem(identifier: "cell1", cellIdentifier: "CellID", title: "Spider-Man", subtitle: "Питер Бенджамин Паркер")
    let cap = CellCompoundItem(identifier: "cell2", cellIdentifier: "CellID", title: "Captain America", subtitle: "Стивен Роджерс")
    let halk = CellCompoundItem(identifier: "cell3", cellIdentifier: "CellID", title: "Halk", subtitle: "Роберт Брюс Бэннер")
    
    let harly = CellCompoundItem(identifier: "cell4", cellIdentifier: "CellID", title: "Харли Квинн", subtitle: "Роберт Харлин Фрэнсис Квинзель")
    let batman = CellCompoundItem(identifier: "cell5", cellIdentifier: "CellID", title: "Batman", subtitle: "Брюс Вэйн")
    let flash = CellCompoundItem(identifier: "cell6", cellIdentifier: "CellID", title: "Flash", subtitle: "Барри Аллен")
    
    section1.add(spider, cap, halk)
    section2.add(harly, batman, flash)
    
    datasource.add(section1, section2)
    
    tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let section = self.datasource.items[section] as? SectionCompoundItemProtocol else {
      return nil
    }
    
    return section.header
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let section = self.datasource.items[section]
    return section.items.count
  }
  
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard let section = self.datasource.items[section] as? SectionCompoundItemProtocol else {
      return nil
    }
    
    return section.footer
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = self.datasource.items[indexPath.section]
    if let cellModel = section.items[indexPath.row] as? CellCompoundItemProtocol {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
      cell.textLabel?.text = cellModel.title
      cell.detailTextLabel?.text = cellModel.subtitle
      return cell
    }
    
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.datasource.items.count
  }
}

