//
//  NetworkUtils.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import Foundation

class NetworkUtils {
    
    public static var panelID: String {
        get {
            return UserDefaults.standard.string(forKey: "panelID4") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "panelID4")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getEthosBase(completion: @escaping (_ model: Ethos?) -> ()) {
        let finalURL = URL(string: "http://" + NetworkUtils.panelID + ".ethosdistro.com/?json=yes")!
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
            }
            }.resume()
    }
    
    static func getHashes(rigID: String,completion: @escaping (_ model: Hashes?) -> ()) {
        let hashesURL = URL(string: "http://ethosdistro.com/graphs/?rig=" + rigID + "&panel=" + NetworkUtils.panelID + "&type=miner_hashes&json=yes")!
        URLSession.shared.dataTask(with: hashesURL) { (data, _, error) in
            if error != nil {
                print(error ?? "Error loading data")
                //todo handle this
                completion(nil)
            } else {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary else {
                        return
                    }
                    
                    let hashModel = Hashes.init(dictionary: json)
                    completion(hashModel)
                } catch let error as NSError {
                    print(error)
                    completion(nil)
                }
                completion(nil)
            }
            }.resume()
    }
    
    static func getTemperatures(rigID: String,completion: @escaping (_ model: Temperatures?) -> ()) {
        let tempsURL = URL(string: "http://ethosdistro.com/graphs/?rig=" + rigID + "&panel=" + NetworkUtils.panelID + "&type=miner_hashes&json=yes")!
        URLSession.shared.dataTask(with: tempsURL) { (data, _, error) in
            if error != nil {
                print(error ?? "Error loading data")
                //todo handle this
                completion(nil)
            } else {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary else {
                        return
                    }
                    
                    let tempsModel = Temperatures.init(dictionary: json)
                    completion(tempsModel)
                } catch let error as NSError {
                    print(error)
                    completion(nil)
                }
                completion(nil)
            }
            }.resume()
    }
    
    static func getWatts(rigID: String,completion: @escaping (_ model: Watts?) -> ()) {
        let tempsURL = URL(string: "http://ethosdistro.com/graphs/?rig=" + rigID + "&panel=" + NetworkUtils.panelID + "&type=miner_hashes&json=yes")!
        URLSession.shared.dataTask(with: tempsURL) { (data, _, error) in
            if error != nil {
                print(error ?? "Error loading data")
                //todo handle this
                completion(nil)
            } else {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary else {
                        return
                    }
                    
                    let wattsModel = Watts.init(dictionary: json)
                    completion(wattsModel)
                } catch let error as NSError {
                    print(error)
                    completion(nil)
                }
                completion(nil)
            }
            }.resume()
    }
}
