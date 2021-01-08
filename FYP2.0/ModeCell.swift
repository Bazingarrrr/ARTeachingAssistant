//
//  ModeCell.swift
//  FYP2.3
//
//  Created by Jason on 8/1/2021.
//

import UIKit

class ModeCell: UITableViewCell {

    @IBOutlet weak var modeName: UILabel!
    
    @IBOutlet weak var modeImage: UIImageView!
    
    func set( modeName:String, modeImage:UIImage? ) {
        self.modeName.text = modeName
        self.modeImage.image = modeImage!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
