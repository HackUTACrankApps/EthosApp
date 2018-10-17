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
                    //var havg = [String] ()
                    let havg = NSMutableDictionary()
                    var ttotal = 0.0
                    var tcount = 0.0
                    //var tavg = [String] ()
                    let tavg = NSMutableDictionary()
                    var wtotal = 0.0
                    var wcount = 0.0
                    //var wavg = [String] ()
                    let wavg = NSMutableDictionary()
                    for gpu in hashes.allKeys {
                        for item in (hashes[gpu] as! NSArray){
                            if let hrange = (item as! String).range(of: " ") {
                                let hash = (item as! String).substring(from: hrange.upperBound)
                                let hdoubs = Double(hash)
                                htotal += hdoubs ?? 0.0
                            }
                            hcount += 1
                         }
                        //havg.append((gpu as! String) + " " + String(format: "%0.2f", htotal/hcount))
                        havg.setValue(String(format: "%0.2f", htotal/hcount), forKey: gpu as! String)
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
                        //tavg.append((gpu as! String) + " " + String(format: "%0.2f", ttotal/tcount))
                        tavg.setValue(String(format: "%0.2f", ttotal/tcount), forKey: gpu as! String)
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
                        //wavg.append((gpu as! String) + " " + String(format: "%0.2f", wtotal/wcount))
                        wavg.setValue(String(format: "%0.2f", wtotal/wcount), forKey: gpu as! String)
                    }
                    
                    let uptime = "\(((Int(self.miner!.uptime ?? "0") ?? 0) / 3600)) hours \(((Int(self.miner!.uptime ?? "0") ?? 0) % 3600) / 60) minutes \(((Int(self.miner!.uptime ?? "0") ?? 0) % 3600) % 60) seconds"
                    let minerup = "\(((self.miner!.miner_secs ?? 0) / 3600)) hours \(((self.miner!.miner_secs ?? 0) % 3600) / 60) minutes \(((self.miner!.miner_secs ?? 0) % 3600) % 60) seconds"
                    
                    /*
                    var curHash: [Int] = []
                    var curTemp: [Int] = []
                    var curPtun: [Int] = []
                    var curWatt: [Int] = []
                    var curFans: [Int] = []
                    var curCore: [Int] = []
                    var curMemo: [Int] = []
                    var vRam: [Int] = []
                    */
                    
                    DispatchQueue.main.async {
                        //Update the label here
                        let text = NSMutableAttributedString(string: "")
                        let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                        let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
                        text.append(NSAttributedString(string: "\tIP: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.ip!)\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tDriver: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.driver ?? "")", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tAlgorithm: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.miner ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tPool: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.pool ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tTotal Hash: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.hash ?? 0)\n", attributes: boldAttributes))
                        
                        /*text.append(NSAttributedString(string: "\tHash History:\n", attributes: normalAttributes))
                        for item in havg{
                            text.append(NSAttributedString(string: "\t\t\t\(item)\n", attributes: boldAttributes))
                        }
                        
                        text.append(NSAttributedString(string: "\n\tTemperature History:\n", attributes: normalAttributes))
                        for item in tavg{
                            text.append(NSAttributedString(string: "\t\t\t\(item)\n", attributes: boldAttributes))
                        }
                        
                        text.append(NSAttributedString(string: "\n\tWattage History:\n", attributes: normalAttributes))
                        for item in wavg{
                            text.append(NSAttributedString(string: "\t\t\t\(item)\n", attributes: boldAttributes))
                        }*/
                        if ((Int(self.miner!.gpus ?? "") ?? 0) < 6){
                            text.append(NSAttributedString(string: "\n\tGPU:", attributes: normalAttributes))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\t\(i)", attributes: normalAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tHash:", attributes: normalAttributes))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(havg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\tTemps:", attributes: normalAttributes))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(tavg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\tWatts:", attributes: normalAttributes))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(wavg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                        } else if ((Int(self.miner!.gpus ?? "") ?? 0) < 11) {
                            text.append(NSAttributedString(string: "\n\tGPU:", attributes: normalAttributes))
                            for i in 0 ..< 5  {
                                text.append(NSAttributedString(string: "\t\t\(i)", attributes: normalAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tHash:", attributes: normalAttributes))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(havg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: normalAttributes))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(tavg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: normalAttributes))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(wavg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\n\tGPU:\t", attributes: normalAttributes))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(i)\t", attributes: normalAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tHash:", attributes: normalAttributes))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(havg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: normalAttributes))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(tavg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: normalAttributes))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(wavg["GPU" + String(i)] ?? "0")", attributes: boldAttributes))
                            }
                        }
                        
                        text.append(NSAttributedString(string: "\n\n\tUp Time: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(uptime)\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tMiner Up: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(minerup)\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tCPU Temp: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.cpu_temp ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tSystem Load: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.load ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tMother Board: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.mobo ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tTotal RAM: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.ram ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tFree RAM: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.freespace ?? 0)\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tRX: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.rx_kbps ?? "")\n", attributes: boldAttributes))
                        text.append(NSAttributedString(string: "\tTX: ", attributes: normalAttributes))
                        text.append(NSAttributedString(string: "\(self.miner!.tx_kbps ?? "")\n", attributes: boldAttributes))

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
