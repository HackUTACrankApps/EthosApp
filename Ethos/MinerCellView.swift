//
//  MinerCellView.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class MinerCellView: UITableViewCell {
    var label: UILabel!
    var icon: UIView!
    var disclousure: UIImageView!
    
    var model: Miner
    
    init(model: MinerModel) {
        super.init(coder: nil)
        
    }
}
