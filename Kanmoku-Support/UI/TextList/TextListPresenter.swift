//
//  TextListPresenter.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/09/29.
//  Copyright © 2019 tkt989. All rights reserved.
//

import Foundation
import UIKit

class TextListPresenter: NSObject, TextListPresenterProtocol {
    private var view: TextListViewProtocol!
    private var textList: [Text]!
    private var type: Type!
    private var order: Order!
    
    required init(_ view: TextListViewProtocol) {
        super.init()
        self.view = view
        self.textList = TextService.shared.textList() ?? []
        self.type = TextService.shared.type() ?? Type.recent
        self.order = TextService.shared.order() ?? Order.asc
        
        self.updateTextList()
        self.view.updateType(self.type)
        self.view.updateOrder(self.order)
    }
    
    private func save() {
        TextService.shared.saveTextList(value: self.textList)
        TextService.shared.saveType(value: self.type)
        TextService.shared.saveOrder(value: self.order)
    }
    
    private func updateTextList() {
        self.textList.sort(by: { (a: Text, b: Text) -> Bool in
            if self.type == Type.text {
                if self.order == Order.asc {
                    return a.content < b.content
                } else {
                    return b.content < a.content
                }
            } else {
                if self.order == Order.asc {
                    return a.date > b.date
                } else {
                    return b.date > a.date
                }
            }
        })
        self.view.refreshTextList()
    }
    
    func onOrderClick() {
        if self.order == Order.asc {
            self.order = .desc
        } else {
            self.order = .asc
        }
        self.view.updateOrder(self.order)
        self.updateTextList()
        self.save()
    }
    
    func onTypeClick() {
        if self.type == Type.recent {
            self.type = .text
        } else {
            self.type = .recent
        }
        self.view.updateType(self.type)
        self.updateTextList()
        self.save()
    }
    
    func onTextClick(_ index: Int) {
        self.textList[index].date = Date()
        self.save()
        self.view.back(self.textList[index].content)
    }
}

extension TextListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = textList[indexPath.row].content.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.textList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        textList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.save()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.textList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        self.save()
    }
}
