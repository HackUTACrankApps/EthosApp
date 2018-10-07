//
//  OverviewViewController.swift
//  Ethos
//
//  Created by Carlos Crane on 10/6/18.
//  Copyright © 2018 Crank Apps. All rights reserved.
//

import Anchorage
import UIKit

public class OverviewViewController: UITableViewController {
    public var minerList: [Miner] = []
    public var model: Ethos!
    
    public override func viewDidLoad() {
        if NetworkUtils.panelID.isEmpty {
            if let loginController: Login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")  as? Login {
                loginController.modalPresentationStyle = .fullScreen
                loginController.source = self
                self.present(loginController, animated: true, completion: { () -> Void in
                })
            }
        }
        
        tableView.separatorStyle = .none
        tableView.register(MinerCellView.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.register(OverviewCellView.classForCoder(), forCellReuseIdentifier: "overview")

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
        if minerList.isEmpty && !NetworkUtils.panelID.isEmpty{
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
                //todo somehow show an error
                return
            }
            
            self.model = ethosModel
            self.minerList = (ethosModel.rigs?.miners ?? []).sorted(by: { (A, B) -> Bool in
                return A.condition != "mining" || (Int(A.miner_instance ?? "0") ?? 0) < (Int(B.miner_instance ?? "0") ?? 0)
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
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "overview") as! OverviewCellView
            cell.preservesSuperviewLayoutMargins = false
            let titleString = NSMutableAttributedString(string: "")
            let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
            titleString.append(NSAttributedString(string: "Temp: ", attributes: normalAttributes))
            titleString.append(NSAttributedString(string: "\(self.model.avg_temp ?? 0)°C\n", attributes: boldAttributes))
            
            //Todo these
            titleString.append(NSAttributedString(string: "Alive GPUs: ", attributes: normalAttributes))
            titleString.append(NSAttributedString(string: "\(self.model.alive_gpus ?? 0)\n", attributes: boldAttributes))
            titleString.append(NSAttributedString(string: "Hash rate: ", attributes: normalAttributes))
            titleString.append(NSAttributedString(string: "\(self.model.total_hash ?? 0)", attributes: boldAttributes))
            
            cell.title.attributedText = titleString
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MinerCellView
            cell.setMiner(model: minerList[indexPath.row - 1], parent: self)
            cell.preservesSuperviewLayoutMargins = false
            return cell
        }
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minerList.count + (minerList.count > 0 ? 1 : 0)
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let cell = tableView.cellForRow(at: indexPath) as? MinerCellView {
            cell.openDetails()
        }
    }
}
