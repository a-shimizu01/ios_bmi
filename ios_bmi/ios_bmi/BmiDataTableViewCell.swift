//
//  BmiDataTableViewCell.swift
//  ios_bmi
//
//  Created by a-shimizu on 2019/12/16.
//  Copyright © 2019 a-shimizu. All rights reserved.
//

import UIKit

class BmiDataTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var explanationTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // セルタップ時にセル色がグレーのままになるので、一旦コメントアウト
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
