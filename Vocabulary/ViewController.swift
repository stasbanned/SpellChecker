//
//  ViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 09.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let vocabulary = ["hello", "guys", "how", "bow", "are", "you", "aal", "aah", "aaa", "ara", "ata", "main", "mainly", "on", "the", "plain", "was", "plaint", "in", "pain", "falls"]     //Custom vocabulary
    let logicsObject = Spellchecker()
    var result: String = ""
//    let vocabulary = Vocabulary()     // Web vocabulary
    @IBOutlet weak var finishTextView: UITextView!
    @IBOutlet weak var quantityOfWords: UITextField!
    @IBOutlet weak var acticityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBAction func startTextAction(_ sender: Any) {
    }
    @IBAction func buttonCheckAction(_ sender: Any) {
        let startText = self.startText.text
        acticityIndicator.startAnimating()
        quantityOfWords.isHidden = false
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            self.result = self.logicsObject.checkString(startText: startText, vocabulary: self.vocabulary, countOfWordsPrint: self.countOfWords)
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
        quantityOfWords.isHidden = true
    }
    func countOfWords(quantityOfWords: Int, quantityOfWordsInVocabulary: Int) -> String{
        DispatchQueue.main.async {
            self.quantityOfWords.text = "\(quantityOfWords) of \(quantityOfWordsInVocabulary)"
        }
        return ""
    }
}
