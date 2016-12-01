//
//  RatingPopoverController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 10/6/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit

class RatingPopoverController: UIViewController {

    @IBOutlet var btnGreat: UIButton!
    @IBOutlet var btnGood: UIButton!
    @IBOutlet var btndislike: UIButton!
    @IBOutlet var imgFondo: UIImageView!
    @IBOutlet var ratingStackView: UIStackView!
    
    
    var ratingSeleccted : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let BlurEffect = UIBlurEffect(style: .dark)
        let BlurEffectView = UIVisualEffectView(effect: BlurEffect)
        BlurEffectView.frame = view.bounds
        
        imgFondo.addSubview(BlurEffectView)
        
        /*let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translate = CGAffineTransform(translationX: 0.0, y: 500.0)
        ratingStackView.transform = scale.concatenating(translate)*/
        
        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translate = CGAffineTransform(translationX: 0.0, y: 500.0)
        
        btnGreat.transform = scale.concatenating(translate)
        btnGood.transform = scale.concatenating(translate)
        btndislike.transform = scale.concatenating(translate)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //animacion normal
        /*UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)*/
       
        /*//animacion con rebote amortiguador, entre menos damping mas rebote
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)*/
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnGreat.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.8, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnGood.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 1.4, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.btndislike.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRatingPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            ratingSeleccted = "Me encanta"
        case 2:
            ratingSeleccted = "Me gusta"
        case 3:
            ratingSeleccted = "No me gusta"
        default:
            break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    

}
