//
//  MainPresenter.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 25.09.2021.
//

import Foundation
import RealmSwift


protocol MainPresenterProtocol: class {
    var randomUrl: String { get set }
    func makeRequest()
    func bulidInterfaceOnTheFirstCard()
    func makeRequestForTheSecondCard()
    func updateUrlAndView()
    func saveInDataBase()
    init(networkService: NetworkServiceProtocol, view: MainViewControllerProtocol, savedModel: AtcivityModel)
}

class MainPresenter: MainPresenterProtocol {

    var randomUrl = "http://www.boredapi.com/api/activity/"
    var view: MainViewControllerProtocol!
    var savedModel: AtcivityModel!
    var networkService : NetworkServiceProtocol!
    var dataBaseModel:  AtcivityModel?
    
    required init(networkService: NetworkServiceProtocol, view: MainViewControllerProtocol, savedModel: AtcivityModel) {
        self.networkService = networkService
        self.savedModel = savedModel
        self.view = view
    }
    
    
    func makeRequest() {
        networkService.makeRequest(url: randomUrl, activitiesStruct: savedModel, completion: { atcivityModel in
            guard let atcivityModel = atcivityModel else { return }
            self.view.buildInterface(activitieModel: atcivityModel)
            self.dataBaseModel = atcivityModel
        })
    }
    
    func bulidInterfaceOnTheFirstCard() {
        self.dataBaseModel = savedModel
        self.view.buildInterface(activitieModel: savedModel)
    }
    
    func makeRequestForTheSecondCard() {
        networkService.makeRequest(url: randomUrl, activitiesStruct: savedModel, completion: { atcivityModel in
            if atcivityModel?.activity == nil {
                self.view.showAlert()
                UserDefaults.standard.removeObject(forKey: "url")
                UserDefaults.standard.set("http://www.boredapi.com/api/activity/", forKey: "url")
                self.updateUrlAndView()
            }
            self.savedModel = atcivityModel
            self.view.buildInterfaceOnTheSecondCard(activitieModel: atcivityModel!)
        })
    }
    
    func updateUrlAndView() {
        let url = UserDefaults.standard.string(forKey: "url")
        randomUrl = url ?? randomUrl
        view.refresh()
    }
    
    func saveInDataBase() {
        guard let savedModel = dataBaseModel else { return }
        let realm = try! Realm()
        let activityClass = Activitie()
        activityClass.activity = savedModel.activity ?? "Не указано"
        activityClass.participants = savedModel.participants ?? 0
        activityClass.price = savedModel.price ?? 0
        activityClass.type = savedModel.type ?? "Не указано"
        realm.beginWrite()
        realm.add(activityClass)
        try! realm.commitWrite()
    }
}
