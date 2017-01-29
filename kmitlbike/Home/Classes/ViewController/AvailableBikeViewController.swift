//
//  AvailableBikeViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/22/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

protocol AvailableBikeDelegate : class{
    func didSelectBike(bike : BikeModel)
}
class AvailableBikeViewController: BaseViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView : UITableView!
    weak var availableBikeDelegate : AvailableBikeDelegate!
    var viewModel : AvailableBikeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AvailableBikeViewModel(delegate : self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerNib()
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAvailableBike()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onDataDidLoad() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        self.tableView.reloadData()
        
    }
    
    func registerNib(){
        self.tableView.register(UINib(nibName : BorrowBikeTableViewCell.className,bundle : nil), forCellReuseIdentifier: BorrowBikeTableViewCell.className)
    }
    func setupTableView(){
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
}


extension AvailableBikeViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.bikeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BorrowBikeTableViewCell.className) as! BorrowBikeTableViewCell
        cell.bike = self.viewModel.bikeList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bike = self.viewModel.bikeList[indexPath.row]
        self.availableBikeDelegate.didSelectBike(bike: bike)
    }
}
