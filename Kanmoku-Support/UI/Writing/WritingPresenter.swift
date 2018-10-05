// 
//  WritingPresenter.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/06.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation

class WritingPresenter: WritingPresenterProtocol {
    private var view: WritingViewProtocol!
    private var tts: TTS!
    
    required init(_ view: WritingViewProtocol) {
        self.view = view
        self.tts = TTS()
    }
    
    func speech(text: String) {
        self.tts.speech(text) {
            self.view.stopSpeech()
        }
        self.view.startSpeech()
    }
}
