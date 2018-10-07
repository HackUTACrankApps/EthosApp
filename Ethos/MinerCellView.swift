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
    
    weak var parent: OverviewViewController?
        
    var model: Miner?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }
    
    public func openDetails() {
        if let detailController: DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail")  as? DetailViewController {
            detailController.miner = self.model
            parent?.navigationController?.pushViewController(detailController, animated: true)
        }
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
        self.title.heightAnchor == 50
        
        self.ip.topAnchor == self.title.bottomAnchor + 4
        self.ip.leftAnchor == self.icon.rightAnchor + 8
        self.ip.bottomAnchor == self.contentView.bottomAnchor - 8
        
        self.disclosure.widthAnchor == 35
        self.disclosure.widthAnchor == 35
        self.disclosure.centerYAnchor == self.contentView.centerYAnchor
        self.disclosure.rightAnchor == self.contentView.rightAnchor - 8
        self.disclosure.tintColor = UIColor.darkGray
        self.disclosure.contentMode = .scaleAspectFit
        title.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        ip.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        ip.heightAnchor == 10
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        let f = self.contentView.frame
        self.contentView.frame = f.inset(by: UIEdgeInsets(top: CGFloat(5), left: CGFloat(15), bottom: CGFloat(15), right: CGFloat(15)))
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
        
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = false
        self.contentView.layer.cornerRadius = 15
        self.contentView.backgroundColor = .white
        self.backgroundColor = UIColor(hexString: "#F1F3F4")
        self.contentView.elevate(2)
    }
    
    func setMiner(model: Miner, parent: OverviewViewController) {
        self.model = model
        self.parent = parent
        
        self.title.text = "\(model.minerId!) (\(model.miner_instance ?? "0")/\(model.gpus ?? "0"))"
        self.ip.text = model.ip
        
        if let condition = model.condition {
            if condition == "mining" {
                self.icon.backgroundColor = UIColor.green
            } else {
                self.icon.backgroundColor = UIColor.red
            }
        }
    }
}
extension UIView {
    func elevate(_ elevation: Double) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowRadius = CGFloat(elevation)
        self.layer.shadowOpacity = 0.24
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
