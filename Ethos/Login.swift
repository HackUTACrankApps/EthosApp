//
//  Login.swift
//  Ethos
//
//  Created by Sammy Hamwi , Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class Login: UIViewController {
    
    @IBOutlet weak var ethos_logo: UIImageView!
    
    @IBOutlet weak var userInputField: UITextField!
    
    
    @IBAction func submitHash(_ sender: Any) {
        NetworkUtils.panelID = userInputField?.text ?? ""
    }
}

