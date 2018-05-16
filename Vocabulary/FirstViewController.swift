//
//  FirstViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let hello = VocabularyCheck()
    let hellos = DownloadVocabulary()
    let vocabulary = ["hello", "guys", "how", "bow", "are", "you", "aal", "aah", "aaa", "ara", "ata", "main", "mainly", "on", "the", "plain", "was", "plaint", "in", "pain", "falls"]
//    let vocabulary = Vocabulary()
    @IBOutlet weak var checkVocabularyTextField: UILabel!
    @IBOutlet weak var informationAboutVocabulary: UILabel!
    @IBOutlet weak var checkingProgressBar: UIProgressView!
    @IBOutlet weak var downloadingProgressBar: UIProgressView!
    @IBOutlet weak var checkVocabularyButtonOutlet: UIButton!
    @IBOutlet weak var downloadButtonOutlet: UIButton!
    @IBOutlet weak var goToSecondScreenButtonOutlet: UIButton!
    @IBAction func checkVocabularyButton(_ sender: Any) {
        checkingProgressBar.isHidden = false
        checkingProgressBar.progress = 0
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.hello.vocabularyChecking(vocabulary: self.vocabulary, checkProgBarBoolFunc: self.checkProgBarBoolFunc, infAboutVocFunc: self.infAboutVocFunc, infAboutVocTextFunc: self.infAboutVocTextFunc, downButtFunc: self.downButtFunc, checkProgBarCountFunc: self.checkProgBarCountFunc, goToNextScreenFunc: self.goToNextScreenFunc)
        }
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        let queue = DispatchQueue.global(qos: .utility)
        downloadingProgressBar.isHidden = false
        queue.async {
            self.hellos.vocabularyDownloading(vocabulary: self.vocabulary, downProgrBarFunc: self.downProgBarCountFunc, secondScreenIsButtFunc: self.goToNextScreenFunc, downProgrBarIsViewFunc: self.downProgrBarIsViewFunc)
        }
    }
    
    @IBAction func goToSecondScreenButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadingProgressBar.isHidden = true
        checkingProgressBar.isHidden = true
        informationAboutVocabulary.isHidden = true
        goToSecondScreenButtonOutlet.isHidden = true
        downloadButtonOutlet.isHidden = true
    }
    func checkProgBarBoolFunc(isTrue: Bool) -> String {
        DispatchQueue.main.async {
            self.checkingProgressBar.isHidden = isTrue
        }
        return ""
    }
    func infAboutVocFunc(isTrue: Bool) -> String {
        DispatchQueue.main.async {
            self.informationAboutVocabulary.isHidden = isTrue
        }
        return ""
    }
    func infAboutVocTextFunc(isTrue: String) -> String {
        DispatchQueue.main.async {
            self.informationAboutVocabulary.text = isTrue
        }
        return ""
    }
    func downButtFunc(isTrue: Bool) -> String {
        DispatchQueue.main.async {
            self.downloadButtonOutlet.isHidden = isTrue
        }
        return ""
    }
    func checkProgBarCountFunc(isTrue: Float) -> String {
        DispatchQueue.main.async {
            self.checkingProgressBar.progress = isTrue
        }
        return ""
    }
    func goToNextScreenFunc (isTrue: Bool) -> String {
        DispatchQueue.main.async {
            self.goToSecondScreenButtonOutlet.isHidden = isTrue
        }
        return ""
    }
    func downProgBarCountFunc(isTrue: Float) -> String {
        DispatchQueue.main.async {
            self.downloadingProgressBar.progress = isTrue
        }
        return ""
    }
    func downProgrBarIsViewFunc (isTrue: Bool) -> String {
        DispatchQueue.main.async {
            self.downloadingProgressBar.isHidden = isTrue
        }
        return ""
    }
}
