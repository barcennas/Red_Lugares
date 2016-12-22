//
//  aboutUsContent.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 12/17/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import Foundation

class aboutUsContent: NSObject {
    var sections : [String] = []
    var sectionContent : [[String]] = []
    var sectionLink : [[String]] = []
    
    init(sections : [String], sectionContent : [[String]], sectionLink : [[String]]){
        self.sections = sections
        self.sectionContent = sectionContent
        self.sectionLink = sectionLink
    }
}
