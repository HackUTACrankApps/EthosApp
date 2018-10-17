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
                        havg.setValue(String(format: "%0.1f", htotal/hcount), forKey: gpu as! String)
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
                        tavg.setValue(String(format: "%0.1f", ttotal/tcount), forKey: gpu as! String)
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
                        wavg.setValue(String(format: "%0.1f", wtotal/wcount), forKey: gpu as! String)
                    }
                    
                    let uptime = "\(((Int(self.miner!.uptime ?? "0") ?? 0) / 3600)) hours \(((Int(self.miner!.uptime ?? "0") ?? 0) % 3600) / 60) minutes \(((Int(self.miner!.uptime ?? "0") ?? 0) % 3600) % 60) seconds"
                    let minerup = "\(((self.miner!.miner_secs ?? 0) / 3600)) hours \(((self.miner!.miner_secs ?? 0) % 3600) / 60) minutes \(((self.miner!.miner_secs ?? 0) % 3600) % 60) seconds"
                    
                    let curHash = (self.miner!.miner_hashes ?? "").characters.split{$0 == " "}.map(String.init)
                    let curTemp = (self.miner!.temp ?? "").characters.split{$0 == " "}.map(String.init)
                    let curPtun = (self.miner!.powertune ?? "").characters.split{$0 == " "}.map(String.init)
                    let curWatt = (self.miner!.watts ?? "").characters.split{$0 == " "}.map(String.init)
                    let curVolt = (self.miner!.voltage ?? "").characters.split{$0 == " "}.map(String.init)
                    let curFans = (self.miner!.fanrpm ?? "").characters.split{$0 == " "}.map(String.init)
                    let curCore = (self.miner!.core ?? "").characters.split{$0 == " "}.map(String.init)
                    let curMemo = (self.miner!.mem ?? "").characters.split{$0 == " "}.map(String.init)
                    let vram = (self.miner!.vramsize ?? "").characters.split{$0 == " "}.map(String.init)
                    
                    DispatchQueue.main.async {
                        //Update the label here
                        let text = NSMutableAttributedString(string: "")
                        let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                        let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
                        let monospacedNormalAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Courier", size: 14)]
                        let monospacedBoldAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Courier-Bold", size: 14)]
                        text.append(NSAttributedString(string: "\tIP: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.ip!)", attributes: monospacedBoldAttributes))
                        text.append(NSAttributedString(string: "\tDriver: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.driver ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tAlgorithm: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.miner ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tPool: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.pool ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tTotal Hash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.hash ?? 0)\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        
                        text.append(NSAttributedString(string: "\n\tCurrent Stats:\n", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        
                        if ((Int(self.miner!.gpus ?? "") ?? 0) < 6){
                            text.append(NSAttributedString(string: "\tGPU:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(i)".leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tHash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(curHash[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curTemp[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curWatt[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tPtune:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: ("\(curPtun[i])").trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tVolts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curVolt[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tFans: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curFans[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tCore: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curCore[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tMem:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curMemo[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tVRAM: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(vram[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            
                        } else if((Int(self.miner!.gpus ?? "") ?? 0) < 11){
                            text.append(NSAttributedString(string: "\tGPU:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\(i)".leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tHash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\(curHash[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(curTemp[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(curWatt[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tPtune:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: ("\(curPtun[i])").trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tVolts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(curVolt[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tFans: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(curFans[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tCore: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(curCore[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tMem:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(curMemo[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tVRAM: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\t\(vram[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            
                            text.append(NSAttributedString(string: "\n\n\tGPU:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(i)".leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tHash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(curHash[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curTemp[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curWatt[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tPtune:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: ("\(curPtun[i])").trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tVolts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curVolt[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tFans: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curFans[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tCore: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curCore[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tMem:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(curMemo[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tVRAM: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\t\(vram[i])".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                        }
                        
                        text.append(NSAttributedString(string: "\n\n\tUp Time: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(uptime)\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tMiner Up: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(minerup)\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tCPU Temp: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.cpu_temp ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tSystem Load: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.load ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tMother Board: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.mobo ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tTotal RAM: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.ram ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tFree RAM: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.freespace ?? 0)\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tRX: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.rx_kbps ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\tTX: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        text.append(NSAttributedString(string: "\(self.miner!.tx_kbps ?? "")\n", attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))

                        text.append(NSAttributedString(string: "\n\tHistorical Averages:\n", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                        
                        if ((Int(self.miner!.gpus ?? "") ?? 0) < 6){
                            text.append(NSAttributedString(string: "\tGPU:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(i)".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tHash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(havg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(tavg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(wavg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                        } else if ((Int(self.miner!.gpus ?? "") ?? 0) < 11) {
                            text.append(NSAttributedString(string: "\tGPU:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5  {
                                text.append(NSAttributedString(string: "\(i)".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tHash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\(havg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\(tavg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 0 ..< 5 {
                                text.append(NSAttributedString(string: "\(wavg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\n\tGPU:  ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(i)".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tHash: ", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(havg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tTemps:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(tavg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                            text.append(NSAttributedString(string: "\n\tWatts:", attributes: monospacedNormalAttributes as [NSAttributedString.Key : Any]))
                            for i in 5 ..< (Int(self.miner!.gpus ?? "") ?? 0) {
                                text.append(NSAttributedString(string: "\(wavg["GPU" + String(i)] ?? "0")".trimmingCharacters(in: .whitespaces).leftPadding(toLength: 6 ,withPad:" "), attributes: monospacedBoldAttributes as [NSAttributedString.Key : Any]))
                            }
                        }
                        
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

extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let newLength = self.characters.count
        if newLength < toLength {
            return String(repeatElement(character, count: toLength - newLength)) + self
        } else {
            return self.substring(from: index(self.startIndex, offsetBy: newLength - toLength))
        }
    }
}
