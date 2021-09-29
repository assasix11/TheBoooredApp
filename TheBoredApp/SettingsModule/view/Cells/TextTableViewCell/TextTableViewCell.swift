//
//  TextTableViewCell.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 28.09.2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    var presenter: SettingsPresenterProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TextTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.participants = textField.text
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.participants = textField.text
        print(presenter.participants)
    }
}
