//
//  MainViewController.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 25.09.2021.
//

import UIKit
import CDAlertView


protocol MainViewControllerProtocol: class {
    func buildInterface(activitieModel: AtcivityModel)
    func buildInterfaceOnTheSecondCard(activitieModel: AtcivityModel)
    func refresh()
    func showAlert()
}

class MainViewController: UIViewController {
    private var divisor: CGFloat!
    var presenter: MainPresenterProtocol!
    @IBOutlet weak var secondCardView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var participants: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var secondLabelType: UILabel!
    @IBOutlet weak var secondMainText: UITextView!
    @IBOutlet weak var secondParticipants: UILabel!
    @IBOutlet weak var secondCost: UILabel!
    @IBOutlet weak var reloaderImage: UIImageView!
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var secondSaveLabel: UILabel!
    @IBOutlet weak var writeActivitie: UIImageView!
    @IBOutlet weak var showData: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSetup()
    }
    
    func firstSetup() {
        showWriteScreen()
        showDataBase()
        tapToSave()
        showReload()
        showSettings()
        interfaceSettings(save: saveLabel, card: cardView, labelTypeInFunc: labelType, participantsInFunc: participants, costInFunc: cost)
        interfaceSettings(save: secondSaveLabel, card: secondCardView, labelTypeInFunc: secondLabelType, participantsInFunc: secondParticipants, costInFunc: secondCost)
        presenter.makeRequestForTheSecondCard()
        presenter.makeRequest()
    }
    
    func showWriteScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentWriteScreen))
        writeActivitie.isUserInteractionEnabled = true
        writeActivitie.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func presentWriteScreen() {
        let vc = ModelBuilder.createWriteModule()
        present(vc, animated: true, completion: nil)
    }
    
    func showDataBase() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentDataBase))
        showData.isUserInteractionEnabled = true
        showData.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func presentDataBase() {
        let vc = ModelBuilder.createDataBaseModule()
        present(vc, animated: true, completion: nil)
    }
    
    func showSettings() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showSettingsVc))
        settingImage.isUserInteractionEnabled = true
        settingImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func tapToSave() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(save))
        saveLabel.isUserInteractionEnabled = true
        saveLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func save() {
        presenter.saveInDataBase()
    }
    
    @objc func showSettingsVc() {
        let vc = ModelBuilder.createSettingsModule()
        present(vc, animated: true, completion: nil)
    }
    
    func showReload() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(reload))
        reloaderImage.isUserInteractionEnabled = true
        reloaderImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func reload() {
        UIView.animate(withDuration: 0.4, animations: {
            self.reloaderImage.transform = CGAffineTransform(rotationAngle: .pi)
            self.reloaderImage.transform = .identity
        })
        presenter.updateUrlAndView()
    
    }
    
    func interfaceSettings(save: UILabel, card: UIView, labelTypeInFunc: UILabel, participantsInFunc: UILabel, costInFunc: UILabel) {
        save.clipsToBounds = true
        save.layer.cornerRadius = 20
        save.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        labelTypeInFunc.clipsToBounds = true
        labelTypeInFunc.layer.cornerRadius = 20
        labelTypeInFunc.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        labelTypeInFunc.backgroundColor = .red
        labelTypeInFunc.textColor = .white
        card.layer.cornerRadius = 20
        overrideUserInterfaceStyle = .light
        participantsInFunc.textColor = .lightGray
        costInFunc.textColor = .lightGray
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            CDAlertView(title: "No activity found with the specified parameters", message: "Back to random", type: .notification).show()
        }
    }
    
    @IBAction func panGestureCardView(_ sender: UIPanGestureRecognizer) {
        divisor = (view.frame.width / 2) / 0.61
        guard let card = sender.view else { return }
        let point = sender.translation(in: view)
        let xFromTheCenter = card.center.x - view.center.x
        let scale = min(100/abs(xFromTheCenter), 1)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromTheCenter/divisor).scaledBy(x: scale, y: scale)
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 80 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 80)
                    card.alpha = 0
                }, completion: { _ in
                    self.presenter.bulidInterfaceOnTheFirstCard()
                    self.presenter.makeRequestForTheSecondCard()
                    card.center = self.secondCardView.center
                    card.transform = .identity
                    card.alpha = 1
                })
                return
            } else if card.center.x > (view.frame.width - 80) {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 80)
                    card.alpha = 0
                }, completion: { _ in
                    self.presenter.bulidInterfaceOnTheFirstCard()
                    self.presenter.makeRequestForTheSecondCard()
                    card.center = self.secondCardView.center
                    card.transform = .identity
                    card.alpha = 1

                })
                return
            }

        UIView.animate(withDuration: 0.2, animations: {
            card.center = self.secondCardView.center
            card.transform = .identity

        })
        }
    }
}


extension MainViewController: MainViewControllerProtocol {
    
    func buildInterface(activitieModel: AtcivityModel) {
        DispatchQueue.main.async {
            self.labelType.text = activitieModel.type
            self.participants.text = String(activitieModel.participants ?? 0)
            self.cost.text = String(activitieModel.price ?? 0)
            self.mainText.text = activitieModel.activity
        }
    }
    
    func buildInterfaceOnTheSecondCard(activitieModel: AtcivityModel) {
        DispatchQueue.main.async {
            self.secondLabelType.text = activitieModel.type
            self.secondParticipants.text = String(activitieModel.participants ?? 0)
            self.secondCost.text = String(activitieModel.price ?? 0)
            self.secondMainText.text = activitieModel.activity
        }
    }
    
    func refresh() {
        presenter.makeRequestForTheSecondCard()
        presenter.makeRequest()
    }
}
