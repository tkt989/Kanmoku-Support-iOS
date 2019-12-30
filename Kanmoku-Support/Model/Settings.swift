// 
//  Settings.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/08.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation
import DefaultsKit

class Settings {
    private static let userDefaults = UserDefaults.standard
    static let shared = Settings()
    private init() {
        Settings.userDefaults.register(defaults:
        [
            "reverse_show": true,
            "text_show_size": 24.0
        ])
    }
    
    var isReverseShow: Bool {
        get {
            return Settings.userDefaults.bool(forKey: "reverse_show")
        }
    }
    
    var textShowSize: CGFloat {
        get {
            return CGFloat(Defaults().get(for: Key<Double>("text_show_size")) ?? 24.0)
        }
        set {
            Defaults().set(Double(newValue), for: Key<Double>("text_show_size"))
        }
    }
}
