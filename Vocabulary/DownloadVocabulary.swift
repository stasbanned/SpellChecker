//
//  DownloadVocabulary.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

protocol DownloadVocabularyDelegate: class {
    func goToNextScreenView(isTrue: Bool)
    func downloadProggresBarCount(downloadingProgressBar: Float)
    func downloadProgresBarIsView(isTrue: Bool)
}

class DownloadVocabulary {
    weak var delegate: DownloadVocabularyDelegate?
    var downloadProgresBar: Float = 0
    var downloaProgresBarIsView = true
    var secondScreenButtonIsView = true
    func vocabularyDownloading(vocabulary: [String]) {
        var string = ""
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("file1.txt")
                do {
                    for i in 0..<vocabulary.count {
                        if i != vocabulary.count - 1 {
                            string += vocabulary[i] + "\n"
                        } else {
                            string += vocabulary[i]
                        }
                        downloadProgresBar += 1 / Float(vocabulary.count)
                        delegate?.downloadProggresBarCount(downloadingProgressBar: downloadProgresBar)
                    }
                    try string.write(to: fileURL, atomically: false, encoding: .utf8)
                    secondScreenButtonIsView = false
                    delegate?.goToNextScreenView(isTrue: secondScreenButtonIsView)
                    secondScreenButtonIsView = true
                    delegate?.downloadProgresBarIsView(isTrue: secondScreenButtonIsView)
                } catch {
                    print("error:", error)
                }
            }
        }
    }
}
