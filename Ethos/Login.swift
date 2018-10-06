//
//  Login.swift
//  Ethos
//
//  Created by Sammy Hamwi , Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class Login: UIViewController {
    
    weak var source: OverviewViewController?
    
    @IBOutlet weak var ethos_logo: UIImageView!
        
    @IBOutlet weak var userInputField: UITextField!
    
    @IBAction func didPrimary(_ sender: Any) {
        checkHash()
    }
    
    @IBAction func submitHash(_ sender: Any) {
        checkHash()
    }
    
    func checkHash() {
        let inputField = userInputField?.text ?? ""
        let regex = "^[0-9A-Za-z]{6}$"
        if inputField.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil{
            NetworkUtils.panelID = userInputField.text as! String
            self.dismiss(animated: true) {
                self.source?.loadData()
            }
        } else {
            let alert = UIAlertController(title: "Invalid id", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (_) in
            }))
            present(alert, animated: true)
        }
    }
}

