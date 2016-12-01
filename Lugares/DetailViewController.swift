//
//  DetailViewController.swift
//  Mis Lugares
//
//  Created by Abraham Barcenas M on 10/5/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
// 

import UIKit
import CoreData
import MessageUI

class DetailViewController: UIViewController{

    @IBOutlet var imagenDetalle: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnRating: UIButton!
   
    var place : Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        
        self.title = place.name
        
        self.imagenDetalle.image = UIImage(data: self.place.image as Data)
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.btnRating.setImage(#imageLiteral(resourceName: "rating"), for: .normal)
        if let rating = self.place.rating{
            switch rating {
            case "Me encanta":
                self.btnRating.setImage(#imageLiteral(resourceName: "great"), for: .normal)
            case "Me gusta":
                self.btnRating.setImage(#imageLiteral(resourceName: "good"), for: .normal)
            case "No me gusta":
                self.btnRating.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
            default:
                break
            }
        }else{
            btnRating.setImage(#imageLiteral(resourceName: "rating"), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueRating" {

        }
        
        if segue.identifier == "ShowMap"{
            
            let vc = segue.destination as! MapViewController
            vc.place = self.place;
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let ratingVC = segue.source as? RatingPopoverController{
            
            if let rating = ratingVC.ratingSeleccted{
                
                switch rating {
                case "Me encanta":
                    self.place.rating = "Me encanta"
                    self.btnRating.setImage(#imageLiteral(resourceName: "great"), for: .normal)
                case "Me gusta":
                    self.place.rating = "Me gusta"
                    self.btnRating.setImage(#imageLiteral(resourceName: "good"), for: .normal)
                case "No me gusta":
                    self.place.rating = "No me gusta"
                    self.btnRating.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
                default:
                    break
                }
            
                if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                    let context = container.viewContext
                    
                    do{
                        try context.save()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                
            }
        
        }
    }
    
    
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "PlaceDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceDetailCell
        
        //hace que la cell sea casi trasparente
        //cell.backgroundColor = UIColor.clear
        
        switch indexPath.row {
        case 0:
            cell.lblKey.text = "Nombre"
            cell.lblValor.text = self.place.name
        case 1:
            cell.lblKey.text = "Tipo"
            cell.lblValor.text = self.place.type
        case 2:
            cell.lblKey.text = "Localizacion"
            cell.lblValor.text = self.place.location
        case 3:
            cell.lblKey.text = "Pagina Web"
            cell.lblValor.text = self.place.webPage
        case 4:
            cell.lblKey.text = "Email"
            cell.lblValor.text = self.place.email
        case 5:
            cell.lblKey.text = "Telefono"
            cell.lblValor.text = self.place.telephone
        default:
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 2:
            //Localizacion
            self.performSegue(withIdentifier: "ShowMap", sender: nil)
        case 3:
            //Abrir Pagina Web
            if let webpageURL = URL(string: "http://\(self.place.webPage)"){
                let app = UIApplication.shared
                
                if app.canOpenURL(webpageURL){
                    app.open(webpageURL, options: [:], completionHandler: nil)
                }
            }
        case 4:
            //Logica Email
            if self.place.email != "" {
                if MFMailComposeViewController.canSendMail(){
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([self.place.email!])
                    mail.setSubject("Contato \(self.place.name)")
                    mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
                    
                    present(mail, animated: true)
                }
            }
        case 5:
            //Llamar o mandar SMS
            
            if self.place.telephone != ""{
            
                let alertController = UIAlertController(title: "Contactar con \(self.place.name) ", message: "Por que medio deseas ponerte en contacto?", preferredStyle: .actionSheet)
                
                let actionLLamar = UIAlertAction(title: "Llamar", style: .default, handler: { (llamar) in
                    //logica Llamar
                    if let phoneURL = URL(string: "tel://\(self.place.telephone!)"){
                        let app = UIApplication.shared
                        
                        if app.canOpenURL(phoneURL){
                            app.open(phoneURL, options: [:], completionHandler: nil)
                        }
                        
                    }
                })
                alertController.addAction(actionLLamar)
                
                
                let actionSMS = UIAlertAction(title: "SMS", style: .default, handler: { (sms) in
                    //Logica MSN
                    if MFMessageComposeViewController.canSendText() {
                        let msg = ""
                        let msgVC = MFMessageComposeViewController()
                        msgVC.body = msg
                        msgVC.recipients = [self.place.telephone!]
                        msgVC.messageComposeDelegate = self
                        
                        self.present(msgVC, animated: true, completion: nil)
                        
                    }
                })
                alertController.addAction(actionSMS)
                
                let actionCancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
                alertController.addAction(actionCancel)
                
                present(alertController, animated: true, completion: nil)
            }

        default:
            break
        }
        
    }

}

extension DetailViewController : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print("Resultado: \(result)")
        controller.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
