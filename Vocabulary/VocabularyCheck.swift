//
//  VocabularyCheck.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class VocabularyCheck {
    var checkProgBarCount: Float = 0
    var checkProgBarBool = true
    var infAboutVoc = true
    var infAboutVocText = ""
    var downButt = true
    var goToNextScreenBool = true
    func vocabularyChecking(vocabulary: [String], checkProgBarBoolFunc: @escaping (Bool) -> String, infAboutVocFunc: @escaping (Bool) -> String, infAboutVocTextFunc: @escaping (String) -> String, downButtFunc: @escaping (Bool) -> String, checkProgBarCountFunc: @escaping (Float) -> String, goToNextScreenFunc: @escaping (Bool) -> String) {
        var isFileOk = true
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("file1.txt")
                let savedVocabulary = try String(contentsOf: fileURL)
                if savedVocabulary.components(separatedBy: "\n").count == vocabulary.count {
                    for i in 0..<savedVocabulary.components(separatedBy: "\n").count {
                        if savedVocabulary.components(separatedBy: "\n")[i] == vocabulary[i] {
                            self.checkProgBarCount += 1 / Float(savedVocabulary.components(separatedBy: "\n").count)
                            checkProgBarCountFunc(self.checkProgBarCount)
                            continue
                        } else {
                            self.checkProgBarBool = true
                            checkProgBarBoolFunc(self.checkProgBarBool)
                            isFileOk = false
                            break
                        }
                    }
                } else {
                    self.checkProgBarBool = true
                    checkProgBarBoolFunc(self.checkProgBarBool)
                    isFileOk = false
                }
                self.checkProgBarBool = true
                checkProgBarBoolFunc(self.checkProgBarBool)
                if !isFileOk {
                    self.infAboutVoc = false
                    infAboutVocFunc(self.infAboutVoc)
                    self.infAboutVocText = "File is not OK"
                    infAboutVocTextFunc(self.infAboutVocText)
                    self.downButt = false
                    downButtFunc(self.downButt)
                } else {
                    self.infAboutVoc = false
                    infAboutVocFunc(self.infAboutVoc)
                    self.infAboutVocText = "File is OK"
                    infAboutVocTextFunc(self.infAboutVocText)
                    self.goToNextScreenBool = false
                    goToNextScreenFunc(self.goToNextScreenBool)
                }
            }
        } catch {
            print("error:", error)
        }
    }
}
