// 
//  TextService.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/12/15.
//  Copyright © 2019 tkt989. All rights reserved.
//

import Foundation
import DefaultsKit

///
/// 保存した文字列を表したクラス
///
struct Text: Codable, Equatable {
    public var id: String?
    public var content: String
    public var date: Date
    
    public static func ==(lhs: Text, rhs: Text) -> Bool {
        if lhs.id == nil || rhs.id == nil {
            return false
        }
        
        return lhs.id == rhs.id
    }
}

///
/// 最近、あいうえお順
///
enum Type: String, Codable {
    case recent
    case text
}

///
/// 昇順、降順
///
enum Order: String, Codable {
    case asc
    case desc
}


class TextService {
    static let shared = TextService()
    private init() {}
    
    ///
    /// リストを取得
    /// 
    func textList() -> [Text]? {
        let key = Key<[Text]>("TEXT_LIST")
        let textList = Defaults().get(for: key)
        return textList?.map({ _text in
            var text = _text
            if text.id == nil {
                text.id = UUID().uuidString
            }
            return text
        })
    }
    
    func type() -> Type? {
        let key = Key<Type>("TYPE")
        return Defaults().get(for: key)
    }
    
    func order() -> Order? {
        let key = Key<Order>("ORDER")
        return Defaults().get(for: key)
    }
    
    func saveTextList(value: [Text]) {
        let key = Key<[Text]>("TEXT_LIST")
        return Defaults().set(value, for: key)
    }
    
    func saveType(value: Type) {
        let key = Key<Type>("TYPE")
        return Defaults().set(value, for: key)
    }
    
    func saveOrder(value: Order) {
        let key = Key<Order>("ORDER")
        return Defaults().set(value, for: key)
    }
}
