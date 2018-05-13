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
    let logicsObject = Logics()
    var result: String = ""
//    let vocabulary = Voc()     // Web vocabulary
    @IBOutlet weak var finishTextView: UITextView!
    @IBOutlet weak var countOfWords: UITextField!
    @IBOutlet weak var acticityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBAction func startTextAction(_ sender: Any) {
    }
    @IBAction func buttonCheckAction(_ sender: Any) {
        acticityIndicator.startAnimating()
        countOfWords.isHidden = false
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            self.result = self.logicsObject.result(startText: self.startText.text, vocabulary: self.vocabulary, t: self)
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
        countOfWords.isHidden = true
    }
}

class Logics {
    var finalString: String = ""
    var ew = 0
    var repeating = 0
    var fullArray: [String] = []
    var checkRepeatString = ""
    var fullName: [String] = []
    let alphabetArray = (97...122).map({Character(UnicodeScalar($0))})
    var indexOfArray = -1
    var countOfWords = 0
    func result (startText: String?, vocabulary: [String], t: ViewController) -> String {
        countOfWords = 0
        finalString = ""
        if repeating == 0 { ew = 0 }
        if repeating == 0 {
            checkRepeatString = ""
        }
        var key = -1
        indexOfArray = -1
        var arrayOfStartText = startText?.components(separatedBy: " ")
        first: for i in arrayOfStartText! {
            countOfWords = 0
            if repeating == 0 { ew = 0 }
            var string = ""
            indexOfArray += 1
            if vocabulary.contains(i) {
                finalString += " " + i
                continue first
            }
            var count: [String] = []
            
            second: for _ in vocabulary {
                countOfWords += 1
                    DispatchQueue.main.async {
                        t.countOfWords.text = "\(self.countOfWords) of \(vocabulary.count)"
                    }

                key = -1
                for _ in Array(i) {
                    key += 1
                    var arrayOfCharsForDeleting: [Character] = Array(i)
                    arrayOfCharsForDeleting.remove(at: key)
                    let wordWithDeletedChar = String(arrayOfCharsForDeleting)
                    if !fullArray.contains(wordWithDeletedChar) && repeating == 0 {
                        fullArray.append(wordWithDeletedChar)
                    }
                    if vocabulary.contains((wordWithDeletedChar)) {
                        if !count.contains(wordWithDeletedChar) {
                            if count.count == 0 {
                                count.append(wordWithDeletedChar)
                            } else {
                                count.append(" ")
                                count.append(wordWithDeletedChar)
                            }
                        }
                        string = count .joined(separator: " ")
                        if count.count > 1 {
                            string = "{" + count.joined(separator: " ") + "}"
                        }
                        arrayOfStartText![indexOfArray] = string
                        ew = 1
                    }
                    var forLastIndexInserting = 0
                    third: for z in alphabetArray {
                        if (key + 1) == Array(i).count {
                            forLastIndexInserting += 1
                        }
                        var arrayOfCharsForInserting: [Character] = Array(i)
                        arrayOfCharsForInserting.insert(z, at: key)
                        let wordWithInsertedChar = String(arrayOfCharsForInserting)
                        if !fullArray.contains(wordWithInsertedChar) && repeating == 0 {
                            fullArray.append(wordWithInsertedChar)
                        }
                        if vocabulary.contains(wordWithInsertedChar) {
                            if !count.contains(wordWithInsertedChar) {
                                if count.count == 0 {
                                    count.append(wordWithInsertedChar)
                                } else {
                                    count.append(" ")
                                    count.append(wordWithInsertedChar)
                                }
                            }
                            string = count.joined(separator: " ")
                            if count.count > 1 {
                                string = "{" + count.joined(separator: " ") + "}"
                            }
                            arrayOfStartText![indexOfArray] = string
                            ew = 1
                        }
                        
                        if forLastIndexInserting == alphabetArray.count {
                            key = Array(i).count
                            for z in alphabetArray {
                                var arrayOfCharsForInserting: [Character] = Array(i)
                                arrayOfCharsForInserting.insert(z, at: key)
                                let wordWithInsertedsChar = String(arrayOfCharsForInserting)
                                if !fullArray.contains(wordWithInsertedsChar) && repeating == 0 {
                                    fullArray.append(wordWithInsertedsChar)
                                }

                                if vocabulary.contains(wordWithInsertedsChar) {
                                    if !count.contains(wordWithInsertedsChar) {
                                        if count.count == 0 {
                                            count.append(wordWithInsertedsChar)
                                        } else {
                                            count.append(" ")
                                            count.append(wordWithInsertedsChar)
                                        }
                                    }
                                    string = count.joined(separator: " ")
                                    if count.count > 1 {
                                        string = "{" + count.joined(separator: " ") + "}"
                                    }
                                    arrayOfStartText![indexOfArray] = string
                                    ew = 1
                                }
                            }
                        }
                    }
                }
            }
            
            if ew == 0 {
                raz: for k in fullArray {
                    if !vocabulary.contains(k) && repeating == 0 {
                        repeating = 1
                        result(startText: k, vocabulary: vocabulary, t: t)
                        fullArray = []
                        repeating = 0
                    }
                }
            }
            if string != "" {
                ew = 1
                fullArray = []
            }
            if string == "" && repeating == 0{
                if ew == 0 {
                    string = "{" + i + "?}"
                    arrayOfStartText![indexOfArray] = string
                }
            }
            if string != "" && repeating == 0 {
                finalString += " " + string
            }
            if string != "" && repeating != 0 && string != checkRepeatString{
                finalString += " " + string
            }
            if repeating != 0 && string != ""{
                checkRepeatString = string
            }
        }
        return finalString
    }
    
    func down(c: Int) -> String {
        let a = ViewController()
        return "\(c) of \(a.vocabulary.count)"
    }
    
}

class Voc {
    func voc() -> [String] {
        var fullName: [String] = []
        if let url = URL(string: "https://docs.oracle.com/javase/tutorial/collections/interfaces/examples/dictionary.txt") {
            do {
                let contents = try String(contentsOf: url)
                fullName = contents.components(separatedBy: "\n")
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        return fullName
    }
}
