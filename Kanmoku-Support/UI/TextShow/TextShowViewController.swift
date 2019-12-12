// 
//  TextShowViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

class TextShowViewController: UIViewController, UITextViewDelegate {
    public var text: String!
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = text

        if Settings.sharedInstance.isReverseShow {
            textView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        textView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.textView.centerVertically()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.textView.centerVertically()
    }
}
