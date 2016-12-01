//
//  DetallePlatilloCell.swift
//  Lugares
//
//  Created by Abraham Barcenas M on 10/5/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit

class PlaceDetailCell: UITableViewCell {

    
    @IBOutlet var lblKey: UILabel!
    @IBOutlet var lblValor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
