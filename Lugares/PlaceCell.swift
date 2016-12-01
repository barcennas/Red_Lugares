//
//  PlaceCell
//  Lugares
//
//  Created by Abraham Barcenas M on 10/3/16.
//  Copyright © 2016 Abraham Barcenas M. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet var imagen: UIImageView!
    @IBOutlet var lblNombre: UILabel!
    @IBOutlet var lblTiempo: UILabel!
    @IBOutlet var lblIngredientes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
