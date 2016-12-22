//
//  TutorialContentViewController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 12/12/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit

class TutorialContentViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!
     
    var tutorialStep : TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.tutorialStep.header
        self.contentImageView.image = self.tutorialStep.image
        self.contentLabel.text = self.tutorialStep.content
        self.pageControl.currentPage = self.tutorialStep.index
        
        switch tutorialStep.index {
        case 0...1:
            self.nextButton.setTitle("Siguiente", for: .normal)
        case 2 :
            self.nextButton.setTitle("Empezar", for: .normal)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextPressed(_ sender: Any) {
        switch self.tutorialStep.index {
        case 0...1:
            let pageVC = parent as! TutorialPageViewController
            pageVC.forward(toIndex: self.tutorialStep.index)
            
        case 2:
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedTutorial")
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }


}
