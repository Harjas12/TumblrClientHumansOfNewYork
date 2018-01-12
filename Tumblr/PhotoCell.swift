//
//  CellTableViewCell.swift
//  Tumblr
//
//  Created by Harjas Monga on 1/10/18.
//  Copyright © 2018 Harjas Monga. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
