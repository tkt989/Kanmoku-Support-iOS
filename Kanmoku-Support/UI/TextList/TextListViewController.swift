// 
//  TextListViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/09/18.
//  Copyright © 2019 tkt989. All rights reserved.
//

import UIKit

class TextListViewController: UIViewController, TextListViewProtocol {
    var listener: ((String) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    
    private var presenter: TextListPresenterProtocol!
    private var origin: CGAffineTransform!
    
    var textList: [Text] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.origin = self.orderButton.transform.rotated(by: 0.0)
        
        self.presenter = TextListPresenter(self)
        
        self.tableView.dataSource = self.presenter
        self.tableView.delegate = self
        
        self.orderButton.imageView?.contentMode = .scaleAspectFit
        
        let edit = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(clickEdit(_:)))
        self.navigationItem.rightBarButtonItem = edit
    }
    
    @IBAction func typeClick(_ sender: Any) {
        self.presenter.onTypeClick()
    }
    
    @IBAction func orderClick(_ sender: Any) {
        self.presenter.onOrderClick()
    }
    
    @objc private func clickEdit(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        
        if (self.tableView.isEditing) {
            self.navigationItem.rightBarButtonItem?.title = from("Finish")
        } else {
            self.navigationItem.rightBarButtonItem?.title = from("Edit")
        }
    }
    
    func updateType(_ type: Type) {
        if type == Type.recent {
            self.typeButton.setTitle(from("Recent"), for: .normal)
        } else {
            self.typeButton.setTitle(from("Char"), for: .normal)
        }
    }
    
    func updateOrder(_ order: Order) {
        if order == Order.asc {

            self.orderButton.transform = self.origin
        } else {
            self.orderButton.transform = self.origin.rotated(by: .pi)
        }
    }
    
    func refreshTextList() {
        self.tableView.reloadData()
    }
    
    func back(_ text: String) {
        if let _listener = self.listener {
            _listener(text)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension TextListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.onTextClick(indexPath.row)
    }
}
