//
//  ViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 09.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class SpellCheckerViewController: UIViewController {
    /** Custom vocabulary */
    /**
    let correctVocabulary = [
        "hello", "guys", "how", "bow", "are", "you", "aal", "aah",
        "aaa", "ara", "ata", "main", "mainly", "on", "the", "plain",
        "was", "plaint", "in", "pain", "falls"
    ]
    */
    let logicsObject = Spellchecker()
    var result: String = ""
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
            self.result = self.logicsObject.checkString(startText: startText,
                                                        vocabulary: self.vocabularyFromFile(),
                                                        countOfWordsPrint: self.countOfWords)
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
    func vocabularyFromFile() -> [String] {
        var vocabulary: [String] = []
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("file1.txt")
                let savedText = try String(contentsOf: fileURL)
                vocabulary = savedText.components(separatedBy: "\n")

            }
        } catch {
            print("error:", error)
        }
        return vocabulary
    }
}
