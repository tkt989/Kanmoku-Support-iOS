// 
//  WritingContract.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/06.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation

protocol WritingViewProtocol {
    func startSpeech()
    func stopSpeech()
}

protocol WritingPresenterProtocol {
    func speech(text: String)
}
