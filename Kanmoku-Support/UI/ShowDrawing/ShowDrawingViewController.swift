// 
//  ShowDrawingViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/16.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

class ShowDrawingViewController: UIViewController {
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imageView.image = image
        
        if (Settings.sharedInstance.isReverseShow) {
            self.imageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
