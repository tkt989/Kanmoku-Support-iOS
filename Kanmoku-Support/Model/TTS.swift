// 
//  TTS.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import AVFoundation

public class TTS: NSObject, AVSpeechSynthesizerDelegate {
    private var finishListners: [AVSpeechUtterance: () -> ()] = [:]
    private var synth: AVSpeechSynthesizer
    
    override init() {
        self.synth = AVSpeechSynthesizer()
    }
    
    func speech(_ text: String, rate: Float = 1.0, didFinish: @escaping () -> () = { () in return }) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate * rate
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        self.synth.delegate = self
        self.synth.speak(utterance)
        finishListners[utterance] = didFinish
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        finishListners[utterance]?()
        finishListners.removeValue(forKey: utterance)
    }
}
