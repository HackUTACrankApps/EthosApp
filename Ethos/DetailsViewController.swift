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
            NetworkUtils.getTemperatures(rigID: self.miner!.minerId!) { (returnedTemps) in
                guard let returnedTemps = returnedTemps else {
                    //Uh oh error
                    return
                }
                NetworkUtils.getWatts(rigID: self.miner!.minerId!) { (returnedWatts) in
                    guard let returnedWatts = returnedWatts else {
                        //Uh oh error
                        return
                    }
                    let hashes = returnedHashes.dictionaryRepresentation()
                    let temps = returnedTemps.dictionaryRepresentation()
                    let watts = returnedWatts.dictionaryRepresentation()
                    //print(hashes)
                    //print(temps)
                    //do average calculation here!
                    //Not in the async
                    var htotal = 0.0
                    var hcount = 0.0
                    var havg = [String] ()
                    var ttotal = 0.0
                    var tcount = 0.0
                    var tavg = [String] ()
                    var wtotal = 0.0
                    var wcount = 0.0
                    var wavg = [String] ()
                    for gpu in hashes.allKeys {
                        for item in (hashes[gpu] as! NSArray){
                            if let hrange = (item as! String).range(of: " ") {
                                let hash = (item as! String).substring(from: hrange.upperBound)
                                let hdoubs = Double(hash)
                                htotal += hdoubs ?? 0.0
                            }
                            hcount += 1
                         }
                        havg.append((gpu as! String) + " " + String(format: "%0.2f", htotal/hcount))
                    }
                    for gpu in temps.allKeys {
                        for item in (temps[gpu] as! NSArray){
                            if let trange = (item as! String).range(of: " ") {
                                let hash = (item as! String).substring(from: trange.upperBound)
                                let tdoubs = Double(hash)
                                ttotal += tdoubs ?? 0.0
                            }
                            tcount += 1
                        }
                        tavg.append((gpu as! String) + " " + String(format: "%0.2f", ttotal/tcount))
                    }
                    for gpu in watts.allKeys {
                        for item in (watts[gpu] as! NSArray){
                            if let wrange = (item as! String).range(of: " ") {
                                let hash = (item as! String).substring(from: wrange.upperBound)
                                let wdoubs = Double(hash)
                                wtotal += wdoubs ?? 0.0
                            }
                            wcount += 1
                        }
                        wavg.append((gpu as! String) + " " + String(format: "%0.2f", wtotal/wcount))
                    }
                    DispatchQueue.main.async {
                        //Update hte label here
                        let text = NSMutableAttributedString(string: "")
                        let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                        let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
                        
                        /*for gpu in hashes.allKeys {
                         text.append(NSAttributedString(string: "\(gpu)\n", attributes: boldAttributes))
                         /*for item in (hashes[gpu] as! NSArray){
                         text.append(NSAttributedString(string: "\(item)\n", attributes: boldAttributes))
                         }*/
                         }*/
                        
                        text.append(NSAttributedString(string: "Hash History:\n", attributes: normalAttributes))
                        for item in havg{
                            text.append(NSAttributedString(string: "\t\(item)\n", attributes: boldAttributes))
                        }
                        
                        text.append(NSAttributedString(string: "\n\nTemperature History:\n", attributes: normalAttributes))
                        for item in tavg{
                            text.append(NSAttributedString(string: "\t\(item)\n", attributes: boldAttributes))
                        }
                        
                        text.append(NSAttributedString(string: "\n\nWattage History:\n", attributes: normalAttributes))
                        for item in wavg{
                            let simple  = String(format: "%.2f", item)
                            text.append(NSAttributedString(string: "\t\(item)\n", attributes: boldAttributes))
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
