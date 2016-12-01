//
//  ViewController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 10/2/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var places : [Place] = []
    var fetchResultsController : NSFetchedResultsController<Place>!
    var searchController : UISearchController!
    var searchResults : [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Bucar lugares..."
        self.searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.searchController.searchBar.barTintColor = UIColor.darkGray
        
        let fetchRequest : NSFetchRequest<Place> = NSFetchRequest(entityName: "Place")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            let context = container.viewContext
            self.fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            self.fetchResultsController.delegate = self
            
            do{
                try fetchResultsController.performFetch()
                self.places = fetchResultsController.fetchedObjects!
            } catch {
                print ("Error: \(error)")
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableViewDataSource
    //Funciones que delegan las tareas de la tabla al ViewController
    
    //Indica el numero de secciones en la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //indica el numero de filas en la tabla (agarras el numero de lugares del array)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return self.searchResults.count
        }else{
            return self.places.count
        }
    }
    
    //funcion de rows reutilizables
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let place : Place
        
        if self.searchController.isActive{
            place = self.searchResults[indexPath.row]
        }else{
            place = self.places[indexPath.row]
        }
        
        let cellID = "TableCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        cell.imagen.image = UIImage(data: place.image as Data)
        cell.lblNombre.text = place.name
        cell.lblTiempo.text = place.type
        cell.lblIngredientes.text = place.location
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        //Borrar
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                let placeToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(placeToDelete)
                
                do{
                    try context.save()
                } catch {
                    print("Error: \(error)")
                }
                
            }
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        //Compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let place : Place
            
            if self.searchController.isActive{
                place = self.searchResults[indexPath.row]
            }else{
                place = self.places[indexPath.row]
            }
            
            let shareDefaultText = "Estoy visitando el lugar \(place.name)"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, UIImage(data: place.image as Data)!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return[shareAction, deleteAction]
        
    }
    
    //MARK: - UITableViewDelegate
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segeDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let lugarSeleccionado : Place
                
                if self.searchController.isActive{
                    lugarSeleccionado = self.searchResults[indexPath.row]
                }else{
                    lugarSeleccionado = self.places[indexPath.row]
                }
                
                let viewDestino = segue.destination as! DetailViewController
                
                viewDestino.place = lugarSeleccionado
                
            }
            
        }
    }
    
    @IBAction func unwindToMainViewControllerSegue(segue: UIStoryboardSegue){
        
        if(segue.identifier == "unwindToMainView"){
            
            /*if let addPlaceVC = segue.source as? AddPlaceViewController{
                if let newPlace = addPlaceVC.place{
                    self.places.append(newPlace)
                    self.tableView.reloadData()
                }
            }*/
        }
        
    }
    
    func filteredContentFor(textToSearch : String){
        self.searchResults = self.places.filter({ (place) -> Bool in
            let nameToFind = place.name.range(of: textToSearch, options: .caseInsensitive)
            let typeToFind = place.type.range(of: textToSearch, options: .caseInsensitive)
            
            if nameToFind != nil{
                return nameToFind != nil
            }else if typeToFind != nil{
                return typeToFind != nil
            }else{
                return false
            }
        })
    }
    
}


extension ViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        //como el indexPath y newIndexPath es opcional se hace un casting seguro
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
            
        }
        self.places = controller.fetchedObjects as! [Place]
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}

extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            self.filteredContentFor(textToSearch: searchText)
            self.tableView.reloadData()
        }
    }
}

