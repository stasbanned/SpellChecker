//
//  Logics.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 13.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//
import UIKit

class Spellchecker {
    var finalString = ""
    var isCorrectedWord = 0
    var repeating = 0
    var fullArray: [String] = []
    var checkRepeatString = ""
    var fullName: [String] = []
    let alphabetArray = (97...122).map({Character(UnicodeScalar($0))})
    var indexOfDictionaryArray = -1
    var quantityOfWords = 0
    func checkString(startText: String?, vocabulary: [String], countOfWordsPrint: @escaping (Int, Int) -> String) -> String {

        quantityOfWords = 0
        finalString = ""
        if repeating == 0 {
            isCorrectedWord = 0
            checkRepeatString = ""
        }
        var key = -1
        indexOfDictionaryArray = -1
        var arrayOfStartText = startText?.components(separatedBy: " ")
        first: for i in arrayOfStartText! {
            quantityOfWords = 0
            if repeating == 0 {
                isCorrectedWord = 0
            }
            var string = ""
            indexOfDictionaryArray += 1
            if vocabulary.contains(i) {
                finalString += " " + i
                continue first
            }
            var count: [String] = []
            
            second: for _ in vocabulary {
                quantityOfWords += 1
                countOfWordsPrint(quantityOfWords, vocabulary.count)
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
                        arrayOfStartText![indexOfDictionaryArray] = string
                        isCorrectedWord = 1
                    }
                    var forLastIndexInserting = 0
                    third: for z in alphabetArray {
                        if key + 1 == Array(i).count {
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
                            arrayOfStartText![indexOfDictionaryArray] = string
                            isCorrectedWord = 1
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
                                    arrayOfStartText![indexOfDictionaryArray] = string
                                    isCorrectedWord = 1
                                }
                            }
                        }
                    }
                }
            }
            
            if isCorrectedWord == 0 {
                raz: for k in fullArray {
                    if !vocabulary.contains(k) && repeating == 0 {
                        repeating = 1
                        checkString(startText: k, vocabulary: vocabulary, countOfWordsPrint: countOfWordsPrint)
                        fullArray = []
                        repeating = 0
                    }
                }
            }
            if string != "" {
                isCorrectedWord = 1
                fullArray = []
            }
            if string == "" && repeating == 0{
                if isCorrectedWord == 0 {
                    string = "{" + i + "?}"
                    arrayOfStartText![indexOfDictionaryArray] = string
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
}
