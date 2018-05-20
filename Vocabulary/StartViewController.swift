//
//  FirstViewController.swift
//  Vocabulary
//
//  Created by Станислав Тищенко on 16.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, VocabularyCheckDelegate, DownloadVocabularyDelegate {
    //var delegate: VocabularyCheckDelegate? = nil
    lazy var check = VocabularyCheck(delegate: self)
    lazy var download = WriteVocabularyToFile(delegate: self)
    let vocabulary = DownloaVocabulary()
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        check.delegate = self
//        download.delegate = self
//    }
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
            self.check.vocabularyChecking(vocabulary: self.vocabulary.downloadVocabularyFromInternet())
        }
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        let queue = DispatchQueue.global(qos: .utility)
        downloadingProgressBar.isHidden = false
        queue.async {
            self.download.vocabularyDownloading(vocabulary: self.vocabulary.downloadVocabularyFromInternet())
        }
    }
    
    @IBAction func goToSecondScreenButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadingProgressBar.isHidden = true
        checkingProgressBar.isHidden = true
        informationAboutVocabularyLabel.isHidden = true
        goToSecondScreenButtonOutlet.isHidden = true
        downloadButtonOutlet.isHidden = true
    }
    func checkProgresBarBool(isHidden: Bool) {
        DispatchQueue.main.async {
            self.checkingProgressBar.isHidden = isHidden
        }
    }
    func infoAboutVocabulary(isHidden: Bool) {
        DispatchQueue.main.async {
            self.informationAboutVocabularyLabel.isHidden = isHidden
            if isHidden {
                self.informationAboutVocabularyLabel.text = "File is OK"
            } else {
                self.informationAboutVocabularyLabel.text = "File is not OK"
            }
        }
    }
    func infoAboutVocabularyText(labelText: String) {
        DispatchQueue.main.async {
            self.informationAboutVocabularyLabel.text = labelText
        }
    }
    func downloadButtoonIsView(isHidden: Bool) {
        DispatchQueue.main.async {
            self.downloadButtonOutlet.isHidden = isHidden
        }
    }
    func checkProgresBarCount(progress: Float) {
        DispatchQueue.main.async {
            self.checkingProgressBar.progress = progress
        }
    }
    func goToNextScreenView(isHidden: Bool) {
        DispatchQueue.main.async {
            self.goToSecondScreenButtonOutlet.isHidden = isHidden
        }
    }
    func downloadProggresBarCount(progress: Float) {
        DispatchQueue.main.async {
            self.downloadingProgressBar.progress = progress
        }
    }
    func downloadProgresBarIsView(isHidden: Bool) {
        DispatchQueue.main.async {
            self.downloadingProgressBar.isHidden = isHidden
        }
    }
}
