// 
//  TemplatesViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/10/27.
//  Copyright © 2018 tkt989. All rights reserved.
//

import UIKit

class TemplatesViewController: UIViewController, TemplatesViewProtocol {
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var presenter: TemplatesPresenterProtocol!
    var situations: [Situation] = []
    var coachMarkController: CoachMarkController?
    var marks: [Mark] {
        get {
            return [
                Mark(message: NSLocalizedString("CoachMarkTemplateList", comment: ""), view: self.tableView),
                Mark(message: NSLocalizedString("CoachMarkShowButton", comment: ""), view: self.showButton),
                Mark(message: NSLocalizedString("CoachMarkSpeechButton", comment: ""), view: self.speechButton)
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = TemplatesPresenter(self)
        self.coachMarkController = CoachMarkController(marks: self.marks, key: "TemplateViewController")

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textView.layer.borderColor = UIColor(hex: "EEEEEE").cgColor
        
        var location = "assets/templates"
        var fileType = "json"
        if let path = Bundle.main.path(forResource: location, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let text = String(data: data, encoding: .utf8)
                
                self.situations = Situation.load(text: text!)
            } catch let error {
                    print(error.localizedDescription)
            }
        }   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.coachMarkController?.start(vc: self)
    }
    
    @IBAction func tapShowText(_ sender: UIButton) {
        let vc = TextShowViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.text = self.textView.text
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func tapSpeech(_ sender: Any) {
        self.presenter.speech(text: self.textView.text)
    }
    @IBAction func tapClear(_ sender: Any) {
        self.textView.text = ""
    }
    
    func startSpeech() {
        self.speechButton.isEnabled = false
    }
    
    func stopSpeech() {
        self.speechButton.isEnabled = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TemplatesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.situations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.situations[section].templates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.situations[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.situations[indexPath.section].templates[indexPath.row].content
        
        return cell
    }
}

extension TemplatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.textView.text += self.situations[indexPath.section].templates[indexPath.row].content + "\n";
    }
}
