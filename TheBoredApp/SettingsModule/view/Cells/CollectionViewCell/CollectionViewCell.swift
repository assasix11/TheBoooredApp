//
//  CollectionViewCell.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 26.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet weak var viewOnCell: UIView!
    
    override func awakeFromNib() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 contentView.leftAnchor.constraint(equalTo: leftAnchor),
                 contentView.rightAnchor.constraint(equalTo: rightAnchor),
                 contentView.topAnchor.constraint(equalTo: topAnchor),
                 contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
             ])
        super.awakeFromNib()
    }
    
    
}
