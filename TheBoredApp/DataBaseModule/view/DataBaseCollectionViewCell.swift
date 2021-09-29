//
//  DataBaseCollectionViewCell.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 29.09.2021.
//

import UIKit

class DataBaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var activity: UITextView!
    @IBOutlet weak var participants: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
