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
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var textButtonShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Show(_ sender: UIButton) {
        performSegue(withIdentifier: "image", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
// MARK: - CanvasDelegate
extension ViewController: CanvasDelegate
{
    func brush() -> Brush? {
        let brush = Brush()
        brush.color = UIColor.black
        brush.width = 10.0
        return brush
    }
    
    func canvas(_ canvas: Canvas, didUpdateDrawing drawing: Drawing, mergedImage image: UIImage?) {
        self.image = image!
    }
    
    func canvas(_ canvas: Canvas, didSaveDrawing drawing: Drawing, mergedImage image: UIImage?) {
        // you can save merged image
        //        if let pngImage = image?.asPNGImage() {
        //            UIImageWriteToSavedPhotosAlbum(pngImage, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        //        }
        
        // you can save strokeImage
        //        if let pngImage = drawing.stroke?.asPNGImage() {
        //            UIImageWriteToSavedPhotosAlbum(pngImage, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        //        }
        
        //        self.updateToolBarButtonStatus(canvas)
        
        // you can share your image with UIActivityViewController
        if let pngImage = image?.asPNGImage() {
            let activityViewController = UIActivityViewController(activityItems: [pngImage], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    // User canceled
                    return
                }
                
                if activityType == UIActivityType.saveToCameraRoll {
                    let alert = UIAlertController(title: nil, message: "Image is saved successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
