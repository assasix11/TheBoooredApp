//
//  SettingsPresenter.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 26.09.2021.
//

import Foundation

protocol SettingsPresenterProtocol {
    var chosenTypes : [String]? { get set }
    var price: Double? { get set }
    var participants: String? { get set }
    func makeUrl()
}

class SettingsPresenter: SettingsPresenterProtocol {
    
    var chosenTypes: [String]?
    var price: Double?
    var participants: String?
    var isItFirstElement = true
    var firstPartOfUrl = "http://www.boredapi.com/api/activity?"
    let defaults = UserDefaults.standard
    var type = "type="
    var minParticipants = "participants="
    let minPrice = "minprice="
    
    private func isItFirst() {
        if isItFirstElement == false {
           firstPartOfUrl.append("&")
        } else {
           isItFirstElement = false 
        }
    }
    
    func makeUrl() {
        UserDefaults.standard.removeObject(forKey: "url")
        if chosenTypes != nil {
            for i in chosenTypes! {
                type.append(i)
                if i != chosenTypes?.last {
                    type.append("&")
                }
            }
            firstPartOfUrl.append(type)
            isItFirstElement = false
        }
        if participants != nil {
            minParticipants.append(participants!)
            isItFirst()
            firstPartOfUrl.append(minParticipants)
        }
        if price != nil {
            isItFirst()
            firstPartOfUrl.append(minPrice)
            firstPartOfUrl.append(String(price!))
        } else {
            isItFirst()
            firstPartOfUrl.append("maxprice=0")
        }
        defaults.set(firstPartOfUrl, forKey: "url")
    }
}
