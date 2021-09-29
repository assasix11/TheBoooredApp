//
//  Activities .swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 25.09.2021.
//

import Foundation

struct AtcivityModel: Codable {
    var activity: String?
    var type: String?
    var participants: Int?
    var price: Double?
    var link: String?
    var key: String?
    var accessibility: Double?
}
