//
//  DetailViewController.swift
//  Ethos
//
//  Created by Vijit Singh on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {
    public var miner: Miner?
    
    override public func viewWillAppear(_ animated: Bool) {
        title = miner?.minerId
    }
}
