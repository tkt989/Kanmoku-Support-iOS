// 
//  TextListViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/09/18.
//  Copyright © 2019 tkt989. All rights reserved.
//

import UIKit

class TextListViewController: UIViewController {
    var listener: ((String) -> Void)?

    
    @IBOutlet weak var tableView: UITableView!
    
    var textList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textList = (UserDefaults.standard.array(forKey: "TEXT_LIST") as? [String]) ?? []

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let edit = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(clickEdit(_:)))
        self.navigationItem.rightBarButtonItem = edit
    }
    
    @objc private func clickEdit(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        
        if (self.tableView.isEditing) {
            self.navigationItem.rightBarButtonItem?.title = "終了"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "編集"
        }
    }
    
    private func save() {
        UserDefaults.standard.set(self.textList, forKey: "TEXT_LIST")
    }
}

extension TextListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _listener = self.listener {
            _listener(textList[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension TextListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = textList[indexPath.row].replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
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
