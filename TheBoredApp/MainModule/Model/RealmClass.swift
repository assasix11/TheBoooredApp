//
//  RealmClass.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 29.09.2021.
//

import Foundation
import RealmSwift

class Activitie: Object {
    @objc dynamic var activity: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var participants: Int = 0
    @objc dynamic var price: Double = 0
}
