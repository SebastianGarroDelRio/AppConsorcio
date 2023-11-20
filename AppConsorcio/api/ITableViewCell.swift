//
//  ITableViewCell.swift
//  AppConsorcio
//
//  Created by DAMII on 5/11/23.
//

import UIKit

class ITableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCodigo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
