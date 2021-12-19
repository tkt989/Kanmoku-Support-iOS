// 
//  TextListContract.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/09/29.
//  Copyright © 2019 tkt989. All rights reserved.
//

import Foundation
import UIKit

protocol TextListViewProtocol {
    func updateType(_ type: Type)
    func updateOrder(_ order: Order)
    func refreshTextList()
    func back(_ text: KSText)
}

protocol TextListPresenterProtocol: UITableViewDataSource {
    func onOrderClick()
    func onTypeClick()
    func onTextClick(_ index: Int)
    func updateTextList()
}
