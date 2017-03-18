//
//  NavigationCell.swift
//  EventOMat
//
//  Created by Louis Franco on 2/11/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import UIKit

class NavigationCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
