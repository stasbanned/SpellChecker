//
//  VocabularyCheck.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

protocol VocabularyCheckDelegate: class {
    func checkProgresBarBool(isTrue: Bool)
    func infoAboutVocabulary(isTrue: Bool)
    func infoAboutVocabularyText(infoAboutVocabulary: String)
    func downloadButtoonIsView(isTrue: Bool)
    func checkProgresBarCount(checkingProgressBar: Float)
    func goToNextScreenView(isTrue: Bool)
}

class VocabularyCheck {
    weak var delegate: VocabularyCheckDelegate?
    var checkProgresBarCount: Float = 0
    var checkProgresBarBool = true
    var infoAboutVocabulary = true
    var infoAboutVocabularyText = ""
    var downloadButtoon = true
    var goToNextScreenBool = true
    func vocabularyChecking(vocabulary: [String]) {
        var isFileOk = true
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("file1.txt")
                let savedVocabulary = try String(contentsOf: fileURL)
                if savedVocabulary.components(separatedBy: "\n").count == vocabulary.count {
                    for i in 0..<savedVocabulary.components(separatedBy: "\n").count {
                        if savedVocabulary.components(separatedBy: "\n")[i] == vocabulary[i] {
                            checkProgresBarCount += 1 / Float(savedVocabulary.components(separatedBy: "\n").count)
                            delegate?.checkProgresBarCount(checkingProgressBar: checkProgresBarCount)
                            continue
                        } else {
                            checkProgresBarBool = true
                            delegate?.checkProgresBarBool(isTrue: checkProgresBarBool)
                            isFileOk = false
                            break
                        }
                    }
                } else {
                    checkProgresBarBool = true
                    delegate?.checkProgresBarBool(isTrue: checkProgresBarBool)
                    isFileOk = false
                }
                checkProgresBarBool = true
                delegate?.checkProgresBarBool(isTrue: checkProgresBarBool)
                if !isFileOk {
                    infoAboutVocabulary = false
                    delegate?.infoAboutVocabulary(isTrue: infoAboutVocabulary)
                    infoAboutVocabularyText = "File is not OK"
                    delegate?.infoAboutVocabularyText(infoAboutVocabulary: infoAboutVocabularyText)
                    downloadButtoon = false
                    delegate?.downloadButtoonIsView(isTrue: downloadButtoon)
                } else {
                    infoAboutVocabulary = false
                    delegate?.infoAboutVocabulary(isTrue: infoAboutVocabulary)
                    infoAboutVocabularyText = "File is OK"
                    delegate?.infoAboutVocabularyText(infoAboutVocabulary: infoAboutVocabularyText)
                    goToNextScreenBool = false
                    delegate?.goToNextScreenView(isTrue: goToNextScreenBool)
                }
            }
        } catch {
            print("error:", error)
        }
    }
}
