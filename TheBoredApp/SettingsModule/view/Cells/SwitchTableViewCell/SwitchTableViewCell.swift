//
//  SwitchTableViewCell.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 28.09.2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    var presenter: SettingsPresenterProtocol!
    @IBOutlet weak var switcher: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func isOn(_ sender: UISwitch) {
        if sender.isOn {
            presenter.price = 0.01
        } else {
            presenter.price = nil
        }
    }
}

