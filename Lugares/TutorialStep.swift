//
//  TutorialStep.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 12/12/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import Foundation
import UIKit

class TutorialStep : NSObject {
    var index = 0
    var header = ""
    var content = ""
    var image : UIImage!
    
    init(index : Int, header: String, content : String, image: UIImage) {
        self.index = index
        self.header = header
        self.content = content
        self.image  = image
    }
    
}
