//
//  ScheduleItemViewController.swift
//  EventOMat
//
//  Created by Louis Franco on 2/26/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import UIKit

class ScheduleItemViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    // This needs to be set in prepareForSegue of the presenter
    var item: ScheduleItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(item.room) @ \(item.startTime):00"
        let itemText = NSMutableAttributedString(string: item.session + "\n\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)])
        itemText.append(NSMutableAttributedString(string: Schedule.sessionText(for: item), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        textView.isScrollEnabled = false
        textView.attributedText = itemText
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            self.textView.isScrollEnabled = true
        }
    }

}
