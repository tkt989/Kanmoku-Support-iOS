// 
//  UITextView+extension.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2019/12/12.
//  Copyright © 2019 tkt989. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
