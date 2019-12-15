// 
//  String+extension.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/12/15.
//  Copyright © 2019 tkt989. All rights reserved.
//

import Foundation

extension String {
    func oneLine() -> String {
        return self.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: nil)
    }
}
