//
//  DetailsViewController.swift
//  Ethos
//
//  Created by Vijit Singh on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class DetailsViewController: UIViewController {
    public var miner: Miner?
    @IBOutlet weak var details: UITextView!
    public var loaded = false
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = miner?.minerId
        self.view.backgroundColor = .white
        details.centerVertically()
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
            var total = 0.0
            var count = 0.0
            var avgHashes = [String] ()
            for gpu in hashes.allKeys {
                for item in (hashes[gpu] as! NSArray){
                    if let range = (item as! String).range(of: " ") {
                        let hash = (item as! String).substring(from: range.upperBound)
                        let doubs = Double(hash)
                        total += doubs ?? 0.0
                    }
                    count += 1
                 }
                avgHashes.append((gpu as! String) + " " + String(total/count))
            }
            
            DispatchQueue.main.async {
                //Update hte label here
                let text = NSMutableAttributedString(string: "")
                let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
                
                
                text.append(NSAttributedString(string: "Hash History:\n", attributes: normalAttributes))
                /*for gpu in hashes.allKeys {
                    text.append(NSAttributedString(string: "\(gpu)\n", attributes: boldAttributes))
                    /*for item in (hashes[gpu] as! NSArray){
                        text.append(NSAttributedString(string: "\(item)\n", attributes: boldAttributes))
                    }*/
                }*/
                for item in avgHashes{
                    text.append(NSAttributedString(string: "\(item)\n", attributes: boldAttributes))
                }
                
                //Todo these
//                titleString.append(NSAttributedString(string: "Alive GPUs: ", attributes: normalAttributes))
//                titleString.append(NSAttributedString(string: "\(self.model.alive_gpus ?? 0)\n", attributes: boldAttributes))
//                titleString.append(NSAttributedString(string: "Hash rate: ", attributes: normalAttributes))
//                titleString.append(NSAttributedString(string: "\(self.model.total_hash ?? 0)", attributes: boldAttributes))
//
//
                self.details.attributedText = text
            }
        }
    }
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
