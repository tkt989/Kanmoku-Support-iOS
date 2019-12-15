//
//  WritingViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit
import Loaf
import FontAwesome_swift

class WritingViewController: UIViewController, WritingViewProtocol {
    @IBOutlet var textView: UITextView!
    @IBOutlet var speechButton: UIButton!
    var text: Text?
    var savable = false
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
        
        self.textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.textView.layer.borderColor = UIColor(hex: "EEEEEE").cgColor
        
        if self.text != nil {
            self.textView.text = self.text?.content
        }
        
        self.setupNavigationItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItems() {
        var items: [UIBarButtonItem] = []
        
        if self.savable {
            let icon = UIImage.fontAwesomeIcon(name: .save, style: .solid, textColor: .black, size: CGSize(width: 28, height: 28))
            let save = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(self.saveText(_:)))
            items.append(save)
        } else {
            let icon = UIImage.fontAwesomeIcon(name: .list, style: .solid, textColor: .black, size: CGSize(width: 28, height: 28))
            let textList = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(self.textListClicked(_:)))
            items.append(textList)
        }
        self.navigationItem.rightBarButtonItems = items
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.textView.isFirstResponder {
            self.textView.resignFirstResponder()
        }
    }
    
    @IBAction func tapShowText(_ sender: UIButton) {
        let vc = TextShowViewController()
        vc.text = self.textView.text
        vc.modalPresentationStyle = .fullScreen
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
        
        var textList: [Text] = TextService.shared.textList() ?? []
        if self.text != nil {
            let index = textList.index(of: self.text!) ?? textList.count
            self.text!.content = self.textView.text
            self.text!.date = Date()
            textList[index] = self.text!
        } else {
            let text = Text(id: UUID().uuidString, content: self.textView.text, date: Date())
            textList.append(text)
        }
        
        TextService.shared.saveTextList(value: textList)
        
        Loaf("保存しました", state: .success , sender: self).show(Loaf.Duration.short, completionHandler: nil)
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
