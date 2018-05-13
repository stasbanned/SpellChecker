//
//  ViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 09.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Prot {
    
    let vocabulary = ["hello", "guys", "how", "bow", "are", "you", "aal", "aah", "aaa", "ara", "ata", "main", "mainly", "on", "the", "plain", "was", "plaint", "in", "pain", "falls"]     //Custom vocabulary
    let logicsObject = Logics()
    var result: String = ""
//    let vocabulary = Voc()     // Web vocabulary
    @IBOutlet weak var finishTextView: UITextView!
    @IBOutlet weak var countOfWords: UITextField!
    @IBOutlet weak var acticityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var buttonCheck: UIButton!
    var delegator = Logics()
    @IBAction func startTextAction(_ sender: Any) {
    }
    @IBAction func buttonCheckAction(_ sender: Any) {
        let startText = self.startText.text
        acticityIndicator.startAnimating()
        countOfWords.isHidden = false
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            self.result = self.delegator.result(startText: startText, vocabulary: self.vocabulary)
                DispatchQueue.main.async {
                    self.finishTextView.text = self.result
                    self.acticityIndicator.stopAnimating()
                    
                }
            }
    }
    @IBAction func finishTextAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Logics().delegate = self
        delegator.delegate = self
        countOfWords.isHidden = true
    }
    func you(_ info: String) {
        countOfWords.text = info
    }
}
