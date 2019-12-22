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
    private var pinchGesture: UIPinchGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoom(sender:)))

        // Do any additional setup after loading the view.
        textView.text = text
        textView.font = UIFont(name: "arial", size: Settings.shared.textShowSize)

        if Settings.shared.isReverseShow {
            textView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        textView.delegate = self
        textView.addGestureRecognizer(self.pinchGesture)
        
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
    
    @objc func zoom(sender: UIPinchGestureRecognizer) {
        var pointSize = self.textView.font?.pointSize
        pointSize = max(sender.velocity * 1 + pointSize!, 10);
        self.textView.font = UIFont( name: "arial", size: (pointSize)!)
        self.textView.layoutIfNeeded()
        self.textView.centerVertically()
        
        if sender.state == .ended {
            Settings.shared.textShowSize = pointSize!
        }
    }
}
