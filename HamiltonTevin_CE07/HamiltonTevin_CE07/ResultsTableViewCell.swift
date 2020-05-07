//
//  ResultsTableViewCell.swift
//  HamiltonTevin_CE07
//
//  Created by Tevin Hamilton on 9/21/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCityState: UILabel!
    @IBOutlet weak var labelPopulation: UILabel!
    @IBOutlet weak var labelZipCode: UILabel!
    
    override func awakeFromNib() {        super.awakeFromNib()
    // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
