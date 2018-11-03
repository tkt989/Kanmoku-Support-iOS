// 
//  TemplatesContract.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/27.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation

protocol TemplatesViewProtocol {
    func startSpeech()
    func stopSpeech()
}

protocol TemplatesPresenterProtocol {
    func speech(text: String)
}
