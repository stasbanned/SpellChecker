//
//  DownloadVocabulary.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class DownloadVocabulary {
    var downProgrBar: Float = 0
    var downProgBarIsView = true
    var secondScreenButtIsView = true
    func vocabularyDownloading(vocabulary: [String], downProgrBarFunc: (Float) -> String, secondScreenIsButtFunc: (Bool) -> String, downProgrBarIsViewFunc: (Bool) -> String) {
        var string = ""
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("file1.txt")
                do {
                    for i in 0..<vocabulary.count {
                        if i != vocabulary.count - 1 {
                            string += vocabulary[i] + "\n"
                        } else {
                            string += vocabulary[i]
                        }
                        
                        downProgrBar += 1 / Float(vocabulary.count)
                        downProgrBarFunc(downProgrBar)
                    }
                    try string.write(to: fileURL, atomically: false, encoding: .utf8)
                    
                    secondScreenButtIsView = false
                    secondScreenIsButtFunc(secondScreenButtIsView)
                    downProgBarIsView = true
                    downProgrBarIsViewFunc(downProgBarIsView)
                    
                } catch {
                    print("error:", error)
                }
            }
        }
    }
}
