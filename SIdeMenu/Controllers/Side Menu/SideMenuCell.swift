//
//  SideMenuCell.swift
//  IOSOMS
//
//  Created by Yugesh Marahatta on 19/08/2022.
//

import UIKit

class SideMenuCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
        class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Background
                self.backgroundColor = .clear
                
                // Icon
                self.iconImageView.tintColor = .white
        self.iconImageView.tintColor = UIColor.orange
                // Title
                self.titleLabel.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
