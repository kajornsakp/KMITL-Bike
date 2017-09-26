//
//  HistoryViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/6/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {

    var viewModel : HistoryViewModel!
    @IBOutlet weak var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HistoryViewModel(delegate : self)
        viewModel.historyDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        registerNib()
        setupTableView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupTitle(title: "History")
        self.tabBarController?.tabBar.tintColor = KmitlColor.LightMainGreenColor.color()
        viewModel.getBikeHistory()
    }
    
    override func onDataDidLoad() {
        self.tableView.reloadData()
        //TODO: add empty view
    }
    func setupTableView(){
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    func registerNib(){
        self.tableView.register(UINib(nibName: BikeHistoryTableViewCell.className, bundle: nil), forCellReuseIdentifier: BikeHistoryTableViewCell.className)
    }
}

extension HistoryViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.historyList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BikeHistoryTableViewCell.className) as! BikeHistoryTableViewCell
        cell.bikeHistory = self.viewModel.historyList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerFactory.sharedInstance.resolve(service: HistorySummaryViewController.self)
        vc.bikeHistory = self.viewModel.historyList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HistoryViewController : HistoryDelegate{
    
}
