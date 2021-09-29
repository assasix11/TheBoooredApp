//
//  SettingsViewController.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 26.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var table: UITableView!
    var presenter: SettingsPresenterProtocol!
    override func viewDidLoad() {
        presenter = ModelBuilder.initializeSettingsModules()
        super.viewDidLoad()
        tablrViewSettings()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    func tablrViewSettings() {
        table.dataSource = self
        table.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionTableCell")
        table.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        table.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "SwitchTableViewCell")
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.tableFooterView = UIView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)
        presenter.makeUrl()
        if let firstVC = presentingViewController as? MainViewController {
             DispatchQueue.main.async {
                firstVC.presenter.updateUrlAndView()
             }
         }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func refresh() {
       self.table.reloadData()
   }
}



extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "CollectionTableCell", for: indexPath) as! CollectionTableViewCell
            cell.presenter = presenter
            return cell
        }
        else if indexPath.row == 1 {
            let cell = table.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            cell.presenter = presenter
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            cell.presenter = presenter
            return cell
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
