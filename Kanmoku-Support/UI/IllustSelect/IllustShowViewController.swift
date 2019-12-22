// 
//  IllustShowViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/15.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

class IllustShowViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    public var illust: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = illust
        
        if (Settings.shared.isReverseShow) {
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
