//
//  AboutViewController.swift
//  EventOMat
//
//  Created by Louis Franco on 2/27/17.
//  Copyright © 2017 Lou Franco. All rights reserved.
//

import UIKit
import SafariServices

struct Sponsor {
    let imageName: String
    let url: URL
}

class AboutViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!

    let sponsors = [
        Sponsor(imageName: "sponsor-cns", url: URL(string: "https://www.cns.umass.edu/")!),
        Sponsor(imageName: "sponsor-massmutual", url: URL(string: "https://www.massmutual.com/")!),
        Sponsor(imageName: "sponsor-lcm", url: URL(string: "https://lastcallmedia.com/")!),
        Sponsor(imageName: "sponsor-cm", url: URL(string: "http://www.commonmedia.com/")!),
        Sponsor(imageName: "sponsor-platformsh", url: URL(string: "https://platform.sh/")!),
        Sponsor(imageName: "sponsor-bpu", url: URL(string: "http://www.baypath.edu/academics/graduate-programs")!),
        Sponsor(imageName: "sponsor-knectar", url: URL(string: "https://www.knectar.com/")!),
        Sponsor(imageName: "sponsor-kayon", url: URL(string: "https://www.kayonaccelerator.com/")!),
        Sponsor(imageName: "sponsor-softescu", url: URL(string: "https://softescu.com/")!),
        Sponsor(imageName: "sponsor-machinemetrics", url: URL(string: "http://www.machinemetrics.com/")!),
        Sponsor(imageName: "sponsor-fit", url: URL(string: "http://www.fitstaffingsolutions.com/")!),
        Sponsor(imageName: "sponsor-acquia", url: URL(string: "https://www.acquia.com/")!),
        Sponsor(imageName: "sponsor-optasy", url: URL(string: "https://www.optasy.com/quote?nerd")!),
        Sponsor(imageName: "sponsor-dfs", url: URL(string: "https://westernmass.dressforsuccess.org/")!),
        Sponsor(imageName: "sponsor-suitup", url: URL(string: "http://suitupspringfield.com/")!),
    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About us"

        for (index, sponsor) in sponsors.enumerated() {
            let v = makeSponsorView(from: sponsor)
            v.tag = index
            stackView.addArrangedSubview(v)
        }
    }

    func makeSponsorView(from sponsor: Sponsor) -> UIView {
        let iv = UIImageView(image: UIImage(named: sponsor.imageName))
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(AboutViewController.sponsorTapped(sender:)))
        iv.addGestureRecognizer(tap)
        iv.contentMode = .center
        iv.clipsToBounds = true
        return iv
    }

    func sponsorTapped(sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag, index < sponsors.count {
            let sponsorSite = SFSafariViewController(url: sponsors[index].url)
            self.present(sponsorSite, animated: true, completion: nil)
        }
    }

}
