// 
//  DrawingViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/16.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit
import NXDrawKit

class DrawingViewController: UIViewController {
    var canvasView: Canvas!
    var image = UIImage()

    @IBOutlet weak var coachMarkView: UIView!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    var coachMarkController: CoachMarkController?
    var marks: [Mark] {
        get {
            return [
                Mark(message: NSLocalizedString("CoachMarkCanvas", comment: ""), view: self.coachMarkView),
                Mark(message: NSLocalizedString("CoachMarkShowDrawingButton", comment: ""), view: self.showButton),
                Mark(message: NSLocalizedString("CoachMarkDeleteDrawingButton", comment: ""), view: self.deleteButton)
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let canvasView = Canvas()
        canvasView.frame = self.view.frame
        canvasView.delegate = self
        self.canvasView = canvasView

        self.view.addSubview(self.canvasView)
        self.view.sendSubviewToBack(self.canvasView)
        self.view.sendSubviewToBack(self.coachMarkView)
        
        self.coachMarkController = CoachMarkController(marks: self.marks, key: "DrawingViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.coachMarkController?.start(vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showDrawing(_ sender: UIButton) {
        let vc = ShowDrawingView.uiHostingController(image: image)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func clearDrawing(_ sender: UIButton) {
        canvasView.clear()
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

extension DrawingViewController : CanvasDelegate {
    func brush() -> Brush? {
        let brush = Brush()
        brush.color = UIColor.black
        brush.width = 10.0
        return brush
    }
    
    func canvas(_ canvas: Canvas, didUpdateDrawing drawing: Drawing, mergedImage image: UIImage?) {
        guard image != nil else {
            return
        }
        self.image = image!
    }
}
