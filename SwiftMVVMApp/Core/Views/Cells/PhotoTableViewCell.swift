//
//  PhotoTableViewCell.swift
//  SwiftMVVMApp
//
//  Created by DarkMoon on 17/04/25.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var textAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(at photo: Photo){
        self.textAuthor.text = photo.author
    }
    
    
}
