// 
//  Templates.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/15.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation

public struct Situation: Codable {
    init(title: String, templates: [Template]) {
        self.title = title
        self.templates = templates
    }
    
    let title: String
    let templates: [Template]
    
    static func load(text: String) -> [Situation] {
        let situations = try! JSONDecoder().decode([Situation].self, from: text.data(using: .utf8)!)
        return situations
    }
}

public struct Template: Codable {
    init(content: String) {
        self.content = content
    }
    
    let content: String
}
