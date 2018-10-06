//
//  OverviewViewController.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import UIKit

public class OverviewViewController: UITableViewController {
    public var minerList: [Miner] = []
    public override func viewDidLoad() {
        if NetworkUtils.panelID.isEmpty {
            //Display login stuff
        }
        
        tableView.separatorStyle = .none
        tableView.register(MinerCellView.classForCoder(), forCellReuseIdentifier: "cell")
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        if minerList.isEmpty {
            loadData()
        }
    }
    
    func loadData() {
        NetworkUtils.getEthosBase { (ethos) in
            guard let ethosModel = ethos else {
                //Error occured
                print("Uh oh..")
                return
            }
            self.minerList = ethosModel.rigs?.miners ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = "\(ethosModel.alive_rigs ?? 0)/\(ethosModel.total_rigs ?? 0)"
                self.navigationController?.navigationBar.prefersLargeTitles = true
            }
        }
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MinerCellView
        cell.setMiner(model: minerList[indexPath.row])
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minerList.count
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
