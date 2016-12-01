//
//  AddPlaceViewController.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 11/17/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit
import CoreData

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var txtNombre: UITextField!
    @IBOutlet var txtTipo: UITextField!
    @IBOutlet var txtDireccion: UITextField!
    @IBOutlet var txtTelefono: UITextField!
    @IBOutlet var txtPaginaWeb: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var btnMeGusta: UIButton!
    @IBOutlet var btnNoMeGusta: UIButton!
    @IBOutlet var btnMeEncanta: UIButton!
    
    var valoracion = ""
    var place : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        
        txtNombre.delegate = self
        txtTipo.delegate = self
        txtDireccion.delegate = self
        txtTelefono.delegate = self
        txtPaginaWeb.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func valoracionPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            valoracion = "Me gusta"
            btnMeGusta.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btnMeEncanta.tintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
            btnNoMeGusta.tintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        case 2:
            valoracion = "No me gusta"
            btnMeGusta.tintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
            btnMeEncanta.tintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
            btnNoMeGusta.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 3:
            valoracion = "Me encanta"
            btnMeGusta.tintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
            btnMeEncanta.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            btnNoMeGusta.tintColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        default: break
        }
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if imageView.image != #imageLiteral(resourceName: "imagePlaceholder"), let nombre = txtNombre.text, !nombre.isEmpty, let tipo = txtTipo.text, !tipo.isEmpty, let direccion = txtDireccion.text, !direccion.isEmpty, let telefono = txtTelefono.text, let paginaWeb = txtPaginaWeb.text, let email = txtEmail.text {
            
            if(valoracion != ""){
            }
            
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                
                self.place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
                self.place?.name = nombre
                self.place?.type = tipo
                self.place?.location = direccion
                self.place?.telephone = telefono
                self.place?.webPage = paginaWeb
                self.place?.email = email
                self.place?.rating = valoracion
                self.place?.image = UIImagePNGRepresentation(self.imageView.image!)! as NSData
                
                do{
                    try context.save()
                } catch {
                    print("Ha ocurrido un error al guardar el lugar en core data")
                }
            }
            
            performSegue(withIdentifier: "unwindToMainView", sender: self)
            
        }else{
            let alert = UIAlertController(title: "Oops", message: "Parece que te ha faltadado seleccionar una imagen o llenar alguno de los campos.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        //constraints 
        //leading = izquierda   -   Trailing = Derecha
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        //top = arriba   -   bottom = abajo
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        
        dismiss(animated: true, completion: nil)
    }


}
