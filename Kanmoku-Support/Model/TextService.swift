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
struct Text: Codable {
    public var content: String
    public var date: Date
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
        return Defaults().get(for: key)
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
