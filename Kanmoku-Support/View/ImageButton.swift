// 
//  ImageButton.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/17.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit

@IBDesignable class ImageButton: UIView {
    @IBInspectable var image: UIImage = UIImage() {
        didSet {
            button.setImage(image, for: .normal)
        }
    }
    
    private var button: UIButton
    private var shadow: UIView
    
    required public init?(coder aDecoder: NSCoder) {
        button = UIButton()
        shadow = UIView()
        super.init(coder: aDecoder)
        
        button.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        shadow.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        shadow.layer.shadowOffset = .zero
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowRadius = 5
        shadow.layer.shadowOpacity = 0.3
        shadow.layer.cornerRadius = 10
        shadow.backgroundColor = UIColor.white
        
        addSubview(shadow)
        addSubview(button)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
