//
//  NetworkService.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 25.09.2021.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func makeRequest<T: Decodable>(url: String, activitiesStruct: T, completion: @escaping(T) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func makeRequest<T: Decodable>(url: String, activitiesStruct: T, completion: @escaping(T) -> ()) {
        guard let localurl = URL(string: url) else {
        print("error url creation")
        return
        }
        var request = URLRequest(url: localurl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let activities = try? JSONDecoder().decode(T.self, from: data) {
                    completion(activities)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("https request error \(error)")
            }
        }
        task.resume()
    }
}
