//
//  Builder.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 25.09.2021.
//

import Foundation
import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createSettingsModule() -> UIViewController
    static func initializeSettingsModules() -> SettingsPresenter
    static func createDataBaseModule() -> UIViewController
    static func createWriteModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let model = AtcivityModel()
        let view = MainViewController() 
        let networkServiceForBuilder = NetworkService()
        let presenter = MainPresenter(networkService: networkServiceForBuilder, view: view, savedModel: model)
        view.presenter = presenter
        return view
    }
    
    static func createSettingsModule() -> UIViewController {
        let view = SettingsViewController()
        return view
    }
    
    static func initializeSettingsModules() -> SettingsPresenter {
        let presenter = SettingsPresenter()
        return presenter
    }
    
    static func createDataBaseModule() -> UIViewController {
        let presenter = DataBasePresenter()
        let view = DataBaseViewController()
        view.presenter = presenter
        return view
    }
    
    static func createWriteModule() -> UIViewController {
        let view = WriteViewController()
        let presenter = WritePresenter()
        view.presenter = presenter
        return view
    }
}
