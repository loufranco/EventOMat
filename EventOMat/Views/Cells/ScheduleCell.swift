//
//  ScheduleCell.swift
//  EventOMat
//
//  Created by Louis Franco on 2/20/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet var session: UILabel!
    @IBOutlet var room: UILabel!
    @IBOutlet var color: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
