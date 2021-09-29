//
//  DataBasePresenter.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 29.09.2021.
//

import Foundation
import RealmSwift

protocol DataBasePresenterProtocol {
    var activityStruct : [AtcivityModel] { get set }
    func fetch()
}


class DataBasePresenter: DataBasePresenterProtocol {
    var activityStruct = [AtcivityModel]()
    func fetch() {
        let activities = try! Realm().objects(Activitie.self)
        for activity in activities {
            let myActivity = AtcivityModel(activity: activity.activity, type: activity.type, participants: activity.participants, price: activity.price, link: nil, key: nil, accessibility: nil)
            activityStruct.append(myActivity)
        }
    }
}
