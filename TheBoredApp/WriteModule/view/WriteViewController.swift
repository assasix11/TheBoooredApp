//
//  WriteViewController.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 29.09.2021.
//

import UIKit

class WriteViewController: UIViewController {
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var presenter: WritePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        activityTextField.delegate = self
        activityTextField.tag = 1
        typeTextField.delegate = self
        typeTextField.tag = 2
        participantsTextField.delegate = self
        typeTextField.tag = 3
        priceTextField.delegate = self
        priceTextField.tag = 4
    }
    @IBAction func SaveAndClose(_ sender: UIButton) {
        presenter.saveInDataBase()
        dismiss(animated: true, completion: nil)
    }
}

extension WriteViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            presenter.activitieStruct.activity = textField.text
            presenter.count = 1
        case 2:
            presenter.activitieStruct.type = textField.text
            presenter.count = 1
        case 3:
            presenter.activitieStruct.participants = Int(textField.text ?? "0")
            presenter.count = 1
        case 4:
            presenter.activitieStruct.price = Double(textField.text ?? "0")
            presenter.count = 1
        default:
            return
        }
    }
}

