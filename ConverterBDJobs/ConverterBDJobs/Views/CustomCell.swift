//
//  CustomCell.swift
//  ConverterBDJobs
//
//  Created by Imrul Kayes on 6/16/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var taxrateLabel: UILabel!
    @IBOutlet weak var radioBtnIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
