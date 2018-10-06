//
//  NetworkUtils.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import Foundation

class NetworkUtils {
    
    public static var userHash: String {
        return UserDefaults.standard.string(forKey: "userHash") ?? ""
    }
    
    static func getEthosBase(@escaping completion: (model: Ethos?) -> ()) {
        let finalURL = URL(string: "http://" + NetworkUtils.userHash + "ethosdistro.com/?json=yes")!
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if error != nil {
                print(error ?? "Error loading data")
                //todo handle this
                completion(nil)
            } else {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary else {
                        return
                    }
                    
                    let ethosModel = Ethos.init(dictionary: json)
                    completion(ethosModel)
                } catch let error as NSError {
                    print(error)
                    completion(nil)
                }
                completion(nil)
            }
            }.resume()
    }
}
