//
//  AboutUsViewController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 12/14/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit
import SafariServices

class AboutUsViewController: UITableViewController {

    
    let content = aboutUsContent(sections: ["Dejar valoración", "Siguenos en redes sociales"],
                                 sectionContent: [["Valorar en el AppStore","Dejanos tu feedback"],["Facebook", "Twitter", "Instagram"]],
                                 sectionLink: [["https://itunes.apple.com/mx/app/super-mario-run/id1145275343?mt=8","https://www.apple.com/"], ["https://facebook.com/barcenna", "https://twitter.com/Barcennas", "https://www.instagram.com/abarcennas/"]])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //esconde las rallitas de separacion de cada celda despues del ultimo registro
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return self.content.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.content.sectionContent[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsCell", for: indexPath)
        
        let cellContent = self.content.sectionContent[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = cellContent
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.content.sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if let appstoreURL = URL(string: self.content.sectionLink[0][0]){
                    let app = UIApplication.shared
                    
                    if app.canOpenURL(appstoreURL){
                        app.open(appstoreURL, options: [:], completionHandler: nil)
                    }
                }
            case 1:
                performSegue(withIdentifier: "showWebView", sender: self.content.sectionLink[0][1])
            default:
                break
            }
        //Redes Sociales
        case 1:
            if let url = URL(string: self.content.sectionLink[1][indexPath.row]){
                
                let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                
                present(safariViewController, animated: true, completion: nil)
            }
            
        default:
            break
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView"{
            
            let destinationVC = segue.destination as! WebViewController
            destinationVC.URLName = sender as! String
        }

    }
    

}
