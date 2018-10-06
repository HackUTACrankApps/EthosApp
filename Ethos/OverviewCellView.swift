//
//  OverviewCellView.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import Anchorage
import Then
import UIKit

public class OverviewCellView: UITableViewCell {
    var title: UILabel!
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setViews() {
        title = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.numberOfLines = 0
        }
        contentView.addSubview(title)
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = false
        self.contentView.layer.cornerRadius = 15
        self.contentView.backgroundColor = .white
        self.backgroundColor = UIColor(hexString: "#F1F3F4")

        self.contentView.elevate(2)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let f = self.contentView.frame
        self.contentView.frame = f.inset(by: UIEdgeInsets(top: CGFloat(5), left: CGFloat(15), bottom: CGFloat(15), right: CGFloat(15)))
    }

    public func setLayouts() {
        title.edgeAnchors == self.contentView.edgeAnchors + 25
        title.heightAnchor == 75
    }
}
