//
//  Login.swift
//  Ethos
//
//  Created by Sammy Hamwi , Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class Login: UIViewController {
    
    var source: OverviewViewController?
    
    @IBOutlet weak var ethos_logo: UIImageView!
    
    @IBOutlet weak var userInputField: UITextField!
    
    
    @IBAction func submitHash(_ sender: Any) {
        let inputField = userInputField?.text ?? ""
        let regex = "[0-9A-Za-z]"
        if inputField.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil{
            NetworkUtils.panelID = userInputField.text as! String
        } else {
            userInputField?.text = "Not a valid panel ID..."
        }
    }
}

