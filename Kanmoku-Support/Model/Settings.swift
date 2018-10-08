// 
//  Settings.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/08.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation

class Settings {
    private static let userDefaults = UserDefaults.standard
    static let sharedInstance = Settings()
    private init() {
        Settings.userDefaults.register(defaults:
        [
            "reverse_show": true
        ])
    }
    
    var isReverseShow: Bool {
        get {
            return Settings.userDefaults.bool(forKey: "reverse_show")
        }
    }
}
