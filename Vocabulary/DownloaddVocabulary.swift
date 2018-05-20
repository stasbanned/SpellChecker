//
//  Voc.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 13.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class DownloaVocabulary {
    func downloadVocabularyFromInternet() -> [String] {
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
