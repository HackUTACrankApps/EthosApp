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
    @IBOutlet weak var detailLabel: UILabel!
    public var loaded = false
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = miner?.minerId
        self.view.backgroundColor = .white
        if !loaded {
            getData()
            loaded = true
        }
    }
    
    func getData() {
        //Do your data stuff here with NetworkUtils
        
        //In completion block, update detailLabel
        
        NetworkUtils.getHashes(rigID: miner!.minerId!) { (returnedHashes) in
            guard let returnedHashes = returnedHashes else {
                //Uh oh error
                return
            }
            let hashes = returnedHashes.dictionaryRepresentation()
            //print(hashes)
            //do average calculation here!
            //Not in the async
            
            DispatchQueue.main.async {
                //Update hte label here
                let text = NSMutableAttributedString(string: "")
                let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
                
                
                text.append(NSAttributedString(string: "Hash History: ", attributes: normalAttributes))
                for gpu in hashes.allKeys {
                    for item in (hashes[gpu] as! NSDictionary).allKeys{
                        text.append(NSAttributedString(string: "\((hashes[gpu] as! NSDictionary)[item] ?? "")\n", attributes: boldAttributes))
                    }
                }
                
                //Todo these
//                titleString.append(NSAttributedString(string: "Alive GPUs: ", attributes: normalAttributes))
//                titleString.append(NSAttributedString(string: "\(self.model.alive_gpus ?? 0)\n", attributes: boldAttributes))
//                titleString.append(NSAttributedString(string: "Hash rate: ", attributes: normalAttributes))
//                titleString.append(NSAttributedString(string: "\(self.model.total_hash ?? 0)", attributes: boldAttributes))
//
//
                self.detailLabel.attributedText = text
            }
        }
    }
}
