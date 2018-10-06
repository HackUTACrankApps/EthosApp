//
//  MinerCellView.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class MinerCellView: UITableViewCell {
    var title: UILabel!
    var ip: UILabel!
    var totalHash: UILabel!
    var icon: UIView!
    var disclousure: UIImageView!
    
    var model: Miner
    
    init(model: Miner) {
        self.model = model
        super.init(coder: nil)
    }
}
