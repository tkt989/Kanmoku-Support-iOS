// 
//  ViewController.swift
//  
//
//  Created by tkt989 on 2018/04/12.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit
import AVFoundation
import NXDrawKit

class ViewController: UIViewController {
    var image: UIImage = UIImage()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        contentView.sizeToFit()
        navigationItem.title = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    @IBAction func openSetting(_ sender: UIBarButtonItem) {
        let url = URL(string: "app-settings:root=General&path=\(Bundle.main.bundleIdentifier!)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func clickIllustSelect(_ sender: UIButton) {
        let vc = IllustSelectView.uiHostingController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
