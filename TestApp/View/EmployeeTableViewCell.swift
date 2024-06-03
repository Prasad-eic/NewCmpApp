//
//  EmployeeTableViewCell.swift
//  TestApp
//
//  Created by Prasad Lokhande on 23/05/24.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblNameText: UILabel!
    @IBOutlet weak var lblSalaryText: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
