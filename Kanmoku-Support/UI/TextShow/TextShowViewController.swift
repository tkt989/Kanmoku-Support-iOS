// 
//  TextShowViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

class TextShowViewController: UIViewController {
    public var text: String!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = self.text
        
        if (Settings.sharedInstance.isReverseShow) {
            label.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
