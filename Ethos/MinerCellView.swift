//
//  MinerCellView.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import Anchorage
import Then
import UIKit

public class MinerCellView: UITableViewCell {
    var title: UILabel!
    var ip: UILabel!
    var totalHash: UILabel!
    var icon: UIView!
    var disclosure: UIImageView!
    
    var model: Miner?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        self.icon.widthAnchor == 10
        self.icon.heightAnchor == 10
        self.icon.centerYAnchor == self.contentView.centerYAnchor
        self.icon.leftAnchor == self.contentView.leftAnchor + 8
        
        self.title.topAnchor == self.contentView.topAnchor + 8
        self.title.leftAnchor == self.icon.rightAnchor + 8
        
        self.ip.topAnchor == self.title.bottomAnchor + 4
        self.ip.leftAnchor == self.icon.rightAnchor + 8
        self.ip.bottomAnchor == self.contentView.bottomAnchor - 8
        
        self.disclosure.widthAnchor == 35
        self.disclosure.widthAnchor == 35
        self.disclosure.centerYAnchor == self.contentView.centerYAnchor
        self.disclosure.rightAnchor == self.contentView.rightAnchor - 8
        self.disclosure.tintColor = UIColor.darkGray
        self.disclosure.contentMode = .scaleAspectFit
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        var frame = contentView.frame
        contentView.frame = frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    func configureView() {
        self.title = UILabel().then {
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            $0.numberOfLines = 0
        }
        self.ip = UILabel().then {
            $0.font = UIFont(name: "Courier", size: 14)
        }
        self.totalHash = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 20)
        }
        self.icon = UIView().then {
            $0.layer.cornerRadius = 5
            $0.backgroundColor = UIColor.blue
        }
        self.disclosure = UIImageView().then {
            $0.image = UIImage(named: "disclosure")
        }
        self.contentView.addSubview(title)
        self.contentView.addSubview(ip)
        self.contentView.addSubview(totalHash)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(disclosure)
        
        self.contentView.layer.cornerRadius = 15
    }
    
    func setMiner(model: Miner) {
        self.model = model
        
        self.title.text = model.miner
        self.ip.text = model.ip
        //
    }
}
