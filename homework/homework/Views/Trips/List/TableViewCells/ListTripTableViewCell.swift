//
//  ListTripTableViewCell.swift
//  homework
//
//  Created by Santiago Carmona on 26/12/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import UIKit

class ListTripTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak private var contentStack: UIStackView!
    @IBOutlet weak private var idLabel: UILabel!
    @IBOutlet weak private var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(idText: String, distanceText: String) {
        self.idLabel.text = idText
        self.distanceLabel.text = distanceText
    }
}
