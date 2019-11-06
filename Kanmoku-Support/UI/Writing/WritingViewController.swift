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
        let save = UIBarButtonItem(title: from("Save"), style: .plain, target: self, action: #selector(saveText(_:)))
        let textList = UIBarButtonItem(title: from("List"), style: .plain, target: self, action: #selector(textListClicked(_:)))
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
            let alert = UIAlertController(title: from("CanNotSave"), message: from("CanNotSaveEmpty"), preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var textList: [Text] =  (try? JSONDecoder().decode([Text].self, from: UserDefaults.standard.data(forKey: "TEXT_LIST") ?? Data())) ?? []
        textList.append(Text(content: self.textView.text, date: Date()))
        UserDefaults.standard.set(try! JSONEncoder().encode(textList), forKey: "TEXT_LIST")
        
        let alert = UIAlertController(title: from("Saved"), message: from("SavedMessage"), preferredStyle: .alert)
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
