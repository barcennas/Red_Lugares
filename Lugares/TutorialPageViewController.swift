//
//  TutorialPageViewController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 12/12/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var tutorialSteps : [TutorialStep] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstStep = TutorialStep(index: 0, header: "Personaliza", content: "Crea nuevos lugares, sube imagenes y ubicalos con solo unos pocos segundos", image: #imageLiteral(resourceName: "tuto-intro-1"))
        
        self.tutorialSteps.append(firstStep)
        
        let secondStep = TutorialStep(index: 1, header: "Encuentra", content: "Ubica y encuentra tus lugares favoritos atraves del mapa", image: #imageLiteral(resourceName: "tuto-intro-2"))
        
        self.tutorialSteps.append(secondStep)
        
        let thirdSterp = TutorialStep(index: 2, header: "Descrubre", content: "Descubre lugares increibles cerca de ti y compartelos con tus amigos", image: #imageLiteral(resourceName: "tuto-intro-3"))
        
        self.tutorialSteps.append(thirdSterp)
        
        dataSource = self
        if let startVC = self.pageViewController(atIndex: 0){
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forward(toIndex : Int) {
        if let nextVC = self.pageViewController(atIndex: toIndex + 1){
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

}

extension TutorialPageViewController : UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        index = index + 1
        
        return self.pageViewController(atIndex: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        index = index - 1
        
        return self.pageViewController(atIndex: index)
        
    }
    
    func pageViewController(atIndex : Int) -> TutorialContentViewController? {
     
        if atIndex == NSNotFound || atIndex < 0 || atIndex >= self.tutorialSteps.count{
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughPageContent") as? TutorialContentViewController{
        
            pageContentViewController.tutorialStep = self.tutorialSteps[atIndex]
            
            return pageContentViewController
        }
        
        return nil
        
    }

    
}
