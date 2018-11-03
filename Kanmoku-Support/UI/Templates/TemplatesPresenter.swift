// 
//  TemplatesPresenter.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/11/04.
//  Copyright © 2018 tkt989. All rights reserved.
//

import Foundation

class TemplatesPresenter: TemplatesPresenterProtocol {
    private var view: TemplatesViewProtocol!
    private var tts: TTS!
    
    required init(_ view: TemplatesViewProtocol) {
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
