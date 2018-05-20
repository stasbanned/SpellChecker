//
//  VocabularyCheck.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

protocol VocabularyCheckDelegate: class {
    func checkProgresBarBool(isHidden: Bool)
    func infoAboutVocabulary(isHidden: Bool)
    func infoAboutVocabularyText(labelText: String)
    func downloadButtoonIsView(isHidden: Bool)
    func checkProgresBarCount(progress: Float)
    func goToNextScreenView(isHidden: Bool)
}

class VocabularyCheck {
    weak var delegate: VocabularyCheckDelegate?
    init(delegate: VocabularyCheckDelegate) {
        self.delegate = delegate
    }
    var checkProgresBarCount: Float = 0
    var checkProgresBarBool = true
    var infoAboutVocabulary = true
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
                            delegate?.checkProgresBarCount(progress: checkProgresBarCount)
                            continue
                        } else {
                            checkProgresBarBool = true
                            delegate?.checkProgresBarBool(isHidden: checkProgresBarBool)
                            isFileOk = false
                            break
                        }
                    }
                } else {
                    checkProgresBarBool = true
                    delegate?.checkProgresBarBool(isHidden: checkProgresBarBool)
                    isFileOk = false
                }
                checkProgresBarBool = true
                delegate?.checkProgresBarBool(isHidden: checkProgresBarBool)
                if !isFileOk {
                    infoAboutVocabulary = false
                    delegate?.infoAboutVocabulary(isHidden: infoAboutVocabulary)
                    downloadButtoon = false
                    delegate?.downloadButtoonIsView(isHidden: downloadButtoon)
                } else {
                    infoAboutVocabulary = false
                    delegate?.infoAboutVocabulary(isHidden: infoAboutVocabulary)
                    goToNextScreenBool = false
                    delegate?.goToNextScreenView(isHidden: goToNextScreenBool)
                }
            }
        } catch {
            print("error:", error)
        }
    }
}
