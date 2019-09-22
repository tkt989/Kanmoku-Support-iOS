// 
//  WritingViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController, WritingViewProtocol {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var speechButton: UIButton!
    private var presenter: WritingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = WritingPresenter(self)

        // キーボードに完了ボタンを表示する
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(WritingViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textView.inputAccessoryView = keyboardToolbar
        self.textView.becomeFirstResponder()
        
        self.textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        self.textView.layer.borderColor = UIColor(hex: "EEEEEE").cgColor
        
        self.setupNavigationItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItems() {
        let save = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveText(_:)))
        let textList = UIBarButtonItem(title: "一覧", style: .plain, target: self, action: #selector(textListClicked(_:)))
        self.navigationItem.rightBarButtonItems = [textList, save]
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
        self.presenter.speech(text: self.textView.text)
    }
    
    @objc private func saveText(_ sender: UIButton) {
        if self.textView.text.isBlank {
            let alert = UIAlertController(title: "保存できません", message: "空の文章は保存できません", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var textList = UserDefaults.standard.array(forKey: "TEXT_LIST") ?? []
        textList.append(self.textView.text)
        UserDefaults.standard.set(textList, forKey: "TEXT_LIST")
        
        let alert = UIAlertController(title: "保存しました。", message: "「一覧」から保存した文章を読み出すことができます", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func textListClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "textList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TextListViewController
        vc.listener = { text in
            self.textView.text = text
        }
    }
    
    func startSpeech() {
        self.speechButton.isEnabled = false
    }
    
    func stopSpeech() {
        self.speechButton.isEnabled = true
    }
}

extension String {
    var isBlank: Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
