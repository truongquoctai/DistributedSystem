//
//  TableViewCell.swift
//  DistributedSystem
//
//  Created by Trương Quốc Tài on 10/6/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgAvatar.layer.cornerRadius = self.imgAvatar.bounds.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
