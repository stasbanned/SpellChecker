//
//  FirstViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, VocabularyCheckDelegate, DownloadVocabularyDelegate {
    
    let check = VocabularyCheck()
    let download = DownloadVocabulary()
    let vocabulary = SpellCheckerViewController()
    @IBOutlet weak var checkingProgressBar: UIProgressView!
    @IBOutlet weak var checkVocabularyButtonOutlet: UIButton!
    @IBOutlet weak var checkVocabularyLabel: UILabel!
    @IBOutlet weak var downloadButtonOutlet: UIButton!
    @IBOutlet weak var downloadingProgressBar: UIProgressView!
    @IBOutlet weak var goToSecondScreenButtonOutlet: UIButton!
    @IBOutlet weak var informationAboutVocabularyLabel: UILabel!
    
    @IBAction func checkVocabularyButton(_ sender: Any) {
        checkingProgressBar.isHidden = false
        checkingProgressBar.progress = 0
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.check.vocabularyChecking(vocabulary: self.vocabulary.correctVocabulary)
        }
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        let queue = DispatchQueue.global(qos: .utility)
        downloadingProgressBar.isHidden = false
        queue.async {
            self.download.vocabularyDownloading(vocabulary: self.vocabulary.correctVocabulary)
        }
    }
    
    @IBAction func goToSecondScreenButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        check.delegate = self
        download.delegate = self
        super.viewDidLoad()
        downloadingProgressBar.isHidden = true
        checkingProgressBar.isHidden = true
        informationAboutVocabularyLabel.isHidden = true
        goToSecondScreenButtonOutlet.isHidden = true
        downloadButtonOutlet.isHidden = true
    }
    func checkProgresBarBool(isTrue: Bool) {
        DispatchQueue.main.async {
            self.checkingProgressBar.isHidden = isTrue
        }
    }
    func infoAboutVocabulary(isTrue: Bool) {
        DispatchQueue.main.async {
            self.informationAboutVocabularyLabel.isHidden = isTrue
        }
    }
    func infoAboutVocabularyText(infoAboutVocabulary: String) {
        DispatchQueue.main.async {
            self.informationAboutVocabularyLabel.text = infoAboutVocabulary
        }
    }
    func downloadButtoonIsView(isTrue: Bool) {
        DispatchQueue.main.async {
            self.downloadButtonOutlet.isHidden = isTrue
        }
    }
    func checkProgresBarCount(checkingProgressBar: Float) {
        DispatchQueue.main.async {
            self.checkingProgressBar.progress = checkingProgressBar
        }
    }
    func goToNextScreenView(isTrue: Bool) {
        DispatchQueue.main.async {
            self.goToSecondScreenButtonOutlet.isHidden = isTrue
        }
    }
    func downloadProggresBarCount(downloadingProgressBar: Float) {
        DispatchQueue.main.async {
            self.downloadingProgressBar.progress = downloadingProgressBar
        }
    }
    func downloadProgresBarIsView(isTrue: Bool) {
        DispatchQueue.main.async {
            self.downloadingProgressBar.isHidden = isTrue
        }
    }
}
