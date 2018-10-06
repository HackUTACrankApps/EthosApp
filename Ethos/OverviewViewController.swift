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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        if minerList.isEmpty {
            loadData()
        }
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = UIRectEdge.all
        self.extendedLayoutIncludesOpaqueBars = true
        self.tableView.backgroundColor = UIColor(hexString: "#F1F3F4")
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F1F3F4")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func loadData() {
        self.tableView.refreshControl?.beginRefreshing()
        NetworkUtils.getEthosBase { (ethos) in
            guard let ethosModel = ethos else {
                //Error occured
                print("Uh oh..")
                return
            }
            self.minerList = (ethosModel.rigs?.miners ?? []).sorted(by: { (A, B) -> Bool in
                return A.condition != "mining" || Int(A.miner_instance ?? "0") > Int(B.miner_instance ?? "0")
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = "\(ethosModel.alive_rigs ?? 0)/\(ethosModel.total_rigs ?? 0)"
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MinerCellView
        cell.setMiner(model: minerList[indexPath.row])
        cell.preservesSuperviewLayoutMargins = false
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minerList.count
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
