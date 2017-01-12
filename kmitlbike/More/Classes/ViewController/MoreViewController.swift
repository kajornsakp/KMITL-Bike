//
//  MoreViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/11/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

enum MoreTableViewIndex : Int{
    case header = 0,info,button
}

class MoreViewController: BaseViewController {

    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerNib()
        self.setupTableView()
    }

    func registerNib(){
        self.tableView.register(UINib(nibName: MoreHeaderTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MoreHeaderTableViewCell.className)
    }
    func setupTableView(){
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
}

extension MoreViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = MoreTableViewIndex(rawValue: section){
            switch index {
            case .header:
                return 1
            case .info:
                return 2
            case .button:
                return 2
            default:
                return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = MoreTableViewIndex(rawValue: indexPath.section){
            switch index {
            case .header:
                let cell = tableView.dequeueReusableCell(withIdentifier: MoreHeaderTableViewCell.className) as! MoreHeaderTableViewCell
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
