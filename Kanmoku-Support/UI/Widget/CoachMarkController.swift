// 
//  CoachMarkController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2020/02/05.
//  Copyright © 2020 tkt989. All rights reserved.
//

import Foundation
import Instructions
import DefaultsKit

struct Mark {
    var message: String
    var view: UIView
}

class CoachMarkController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    let coachMarksController: CoachMarksController
    let marks: [Mark]
    let key: String
    
    init(marks: [Mark], key: String) {
        self.coachMarksController = CoachMarksController()
        self.marks = marks
        self.key = key
        self.coachMarksController.dataSource = self
    }
    
    func start(vc: UIViewController) {
        if Defaults.shared.get(for: Key(self.key)) == true {
            return
        }
        self.coachMarksController.start(in: .window(over: vc))
        Defaults.shared.set(true, for: Key(self.key))
    }
    
    func stop() {
        self.coachMarksController.stop()
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return self.marks.count
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        let mark = self.marks[index]

        coachViews.bodyView.hintLabel.text = mark.message
        coachViews.bodyView.nextLabel.text = "了解"

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        let mark = self.marks[index]
        return self.coachMarksController.helper.makeCoachMark(for: mark.view, pointOfInterest: nil, cutoutPathMaker: nil)
    }
}
