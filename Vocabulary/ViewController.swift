//
//  ViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 09.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var vocabulary = ["hello", "guys", "how", "are", "you", "aal", "aah", "aaa", "ara", "ata", "main", "mainly", "on", "the", "plain"]
    var ar: [String] = []
    var indexOfArray = -1
    var key = -1
    let alphabetArray = (97...122).map({Character(UnicodeScalar($0))})
    
    @IBOutlet weak var finishTextView: UITextView!
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBAction func startTextAction(_ sender: Any) {
    }
    @IBAction func buttonCheckAction(_ sender: Any) {
        var arrayOfStartText = startText.text?.components(separatedBy: " ")
        first: for i in arrayOfStartText! {
            var string = ""
            indexOfArray += 1
            if vocabulary.contains(i) {
                continue first
            }
            var count: [String] = []
            second: for _ in vocabulary {
                key = -1
                for _ in Array(i) {
                    key += 1
                    var arrayOfCharsForDeleting: [Character] = Array(i)
                    arrayOfCharsForDeleting.remove(at: key)
                    let wordWithDeletedChar = String(arrayOfCharsForDeleting)
                    if vocabulary.contains((wordWithDeletedChar)) {
                        if !count.contains(wordWithDeletedChar) {
                            if count.count == 0 {
                                count.append(wordWithDeletedChar)
                            } else {
                                count.append(" ")
                                count.append(wordWithDeletedChar)
                            }
                        }
                        
                        string = count.joined(separator: " ")
                        if count.count > 1 {
                            string = "{" + count.joined(separator: " ") + "}"
                        }
                        arrayOfStartText![indexOfArray] = string
                    }
                    
                    var forLastIndexInserting = 0
                    third: for z in alphabetArray {
                        if (key + 1) == Array(i).count {
                            forLastIndexInserting += 1
                        }
                        var arrayOfCharsForInserting: [Character] = Array(i)
                        arrayOfCharsForInserting.insert(z, at: key)
                        let wordWithInsertedChar = String(arrayOfCharsForInserting)
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
                        }
                        
                        if forLastIndexInserting == alphabetArray.count {
                            key = Array(i).count
                            for z in alphabetArray {
                                var arrayOfCharsForInserting: [Character] = Array(i)
                                arrayOfCharsForInserting.insert(z, at: key)
                                let wordWithInsertedChar = String(arrayOfCharsForInserting)
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
                                }
                            }
                        }
                    }
                }
            }
            if string == "" {
                string = "{" + i + "?}"
                arrayOfStartText![indexOfArray] = string
            }
            
        }
        
        
        
        finishTextView.text = arrayOfStartText?.joined(separator: " ")
    }
    @IBAction func finishTextAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

