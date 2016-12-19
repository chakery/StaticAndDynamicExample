//
//  WiFiTableViewCell.swift
//  StaticAndDynamicExample
//
//  Created by Chakery on 16/9/5.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class WiFiTableViewCell: UITableViewCell {
    @IBOutlet weak var wifiNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .detailButton
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func dataBind(_ wifiName: String) {
        self.wifiNameLabel.text = wifiName
    }
}
