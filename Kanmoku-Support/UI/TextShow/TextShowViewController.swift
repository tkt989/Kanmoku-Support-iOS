// 
//  TextShowViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit
import DefaultsKit

class TextShowViewController: UIViewController, UITextViewDelegate {
    public var text: String!
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textView.text = text
        textView.font = UIFont(name: "arial", size: Settings.shared.textShowSize)

        if Settings.shared.isReverseShow {
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
    
    @IBAction func zoomIn(_ sender: UIButton) {
        var pointSize = self.textView.font?.pointSize
        pointSize! *= 1.2
        let text = self.textView.text
        self.textView.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.textView.font = UIFont(name: "arial", size: pointSize!)
            self.textView.text = text
            self.textView.centerVertically()
            Settings.shared.textShowSize = pointSize!
        }
    }
    
    @IBAction func zoomOut(_ sender: UIButton) {
        var pointSize = self.textView.font?.pointSize
        pointSize! /= 1.2
        if pointSize! < 10.0 {
            pointSize = 10.0
        }
        let text = self.textView.text
        self.textView.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.textView.font = UIFont(name: "arial", size: pointSize!)
            self.textView.text = text
            self.textView.centerVertically()
            Settings.shared.textShowSize = pointSize!
        }
    }
}
