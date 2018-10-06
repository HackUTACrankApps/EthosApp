//
//  OverviewViewController.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class OverviewViewController: UITableViewController {
    public override func viewDidLoad() {
        if NetworkUtils.userHash.isEmpty {
            //Display login stuff
        }
        NetworkUtils.getEthosBase { (ethos) in
            guard let ethosModel = ethos else {
                //Error occured
                return
            }
            
            //do work here
        }
    }
}
