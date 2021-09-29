//
//  WritePresenter.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 29.09.2021.
//

import Foundation
import RealmSwift

protocol WritePresenterProtocol {
    var count: Int { get set }
    var activitieStruct: AtcivityModel { get set }
    func saveInDataBase()
}

class WritePresenter: WritePresenterProtocol {
    var count = 0
    var activitieStruct = AtcivityModel()
    
        func saveInDataBase() {
            if count == 1 {
            let savedModel = activitieStruct
            let realm = try! Realm()
            let activityClass = Activitie()
            activityClass.activity = savedModel.activity ?? "Не указано"
            activityClass.participants = savedModel.participants ?? 0
            activityClass.price = savedModel.price ?? 0
            activityClass.type = savedModel.type ?? "Не указано"
            realm.beginWrite()
            print("smth")
            print(activityClass)
            realm.add(activityClass)
            try! realm.commitWrite()
            }
        }
    
}
