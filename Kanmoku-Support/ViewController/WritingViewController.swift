// 
//  WritingViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private var tts: TTS = TTS()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(WritingViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textView.inputAccessoryView = keyboardToolbar
        textView.becomeFirstResponder()
        
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        textView.layer.borderColor = UIColor(hex: "EEEEEE").cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.textView.isFirstResponder) {
            self.textView.resignFirstResponder()
        }
    }
    
    @IBAction func tapShowText(_ sender: UIButton) {
        let vc = TextShowViewController()
        vc.text = self.textView.text
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func speech(_ sender: UIButton) {
        sender.isEnabled = false
        tts.speech(self.textView.text, didFinish: { () -> () in
            sender.isEnabled = true
        })
    }
}
