//
//  Lugar.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 10/30/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Place : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var type : String
    @NSManaged var location : String
    @NSManaged var image : NSData
    @NSManaged var webPage : String?
    @NSManaged var telephone : String?
    @NSManaged var rating : String?
    @NSManaged var email : String?
    
    
    /*init(name : String, type : String, location : String, image: NSData, webPage: String, telephone: String){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.webPage = webPage
        self.telephone = telephone
    }*/
    
    
}
