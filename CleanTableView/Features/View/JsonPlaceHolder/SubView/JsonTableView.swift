//
//  JsonTableView.swift
//  CleanTableView
//
//  Created by Canberk Bibican on 26.09.2021.
//

import UIKit

protocol JsonTableViewProtocol {
    func update(newItemList:[PostModel])
}

protocol JsonTableViewOutput: class {
    func onSelected(item:PostModel)
}

// final --> compile süresini azaltmak ve erişilebiliriği kısıtlamak
final class JsonTableView: NSObject {
    
    // lazy --> compile olduğu zaman değerini alsın. Çağırılınca. Performans artışı
    private lazy var itemList: [PostModel] = []
    
    // weak --> çağırılmadan yaratılmıyacak. Sayfa kapatıldığında silinecek.
    /// Json TableView Output Delegate
    weak var delegate: JsonTableViewOutput?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = itemList[indexPath.row].title
        cell.detailTextLabel?.text = itemList[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(item: itemList[indexPath.row])
    }
}

extension JsonTableView: UITableViewDelegate, UITableViewDataSource { }
extension JsonTableView: JsonTableViewProtocol{
    func update(newItemList:[PostModel]){
        self.itemList = newItemList
    }
}
