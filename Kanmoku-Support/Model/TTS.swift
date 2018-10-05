// 
//  TTS.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import AVFoundation

/// 音声をスピーチするクラス
public class TTS: NSObject, AVSpeechSynthesizerDelegate {
    private var finishListeners: [AVSpeechUtterance: () -> ()] = [:]
    private var synth: AVSpeechSynthesizer
    
    override init() {
        self.synth = AVSpeechSynthesizer()
    }
    
    /// 音声をスピーチする
    ///
    /// - Parameters:
    ///   - text:
    ///   - rate:
    ///   - didFinish:
    func speech(_ text: String, rate: Float = 1.0, didFinish: @escaping () -> () = { () in return }) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * rate
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-jp")
        
        self.synth.delegate = self
        self.synth.speak(utterance)
        finishListeners[utterance] = didFinish
    }
    
    
    
    /// スピーチが終了したときのコールバック
    ///
    /// - Parameters:
    ///   - synthesizer:
    ///   - utterance:
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        finishListeners[utterance]?()
        finishListeners.removeValue(forKey: utterance)
    }
}
